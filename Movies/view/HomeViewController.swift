//
//  ViewController.swift
//  Movies
//
//  Created by ashraf on 6/28/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    var presenter = HomePresenter()
    var movies = [Movie]()
    var detailSegueIdentifier = "showMovieDetails"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let returnedMovies = presenter.getMovies() {
            movies = returnedMovies
        }else{
            print("no movies found")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier {
            let detailVC = segue.destination as! DetailViewController
            detailVC.movie = movies[sender as! Int]
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: indexPath.row)
    }
}

