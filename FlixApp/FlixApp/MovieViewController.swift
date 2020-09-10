//
//  MovieViewController.swift
//  FlixApp
//
//  Created by Kierra Hicks on 9/1/20.
//  Copyright © 2020 Kierra Hicks. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var TableView: UITableView!
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.dataSource = self
        TableView.delegate = self

       let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
       let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
       let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
       let task = session.dataTask(with: request) { (data, response, error) in
          // This will run when the network request returns
          if let error = error {
             print(error.localizedDescription)
          } else if let data = data {
             let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

             // TODO: Get the array of movies
        
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.TableView.reloadData()
             // TODO: Store the movies in a property to use elsewhere
             // TODO: Reload your table view data

          }
       }
       task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        
            let cell = TableView.dequeueReusableCell(withIdentifier : "MovieCell") as! MovieCell
        
            let movie = movies[indexPath.row]
            let title = movie["title"] as! String
            cell.textLabel!.text = title
            cell.titleLabel.text = title
            
            
            return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
