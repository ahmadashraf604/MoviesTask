//
//  ViewController.swift
//  Movies
//
//  Created by ashraf on 6/28/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchResultsUpdating {
    
    
    var presenter = HomePresenter()
    var movies = [Movie]()
    var resultMovies = [Movie]()
    var detailSegueIdentifier = "showMovieDetails"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let returnedMovies = presenter.getMovies() {
            movies = returnedMovies
            resultMovies = returnedMovies
        }else{
            print("no movies found")
        }
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 0 {
            resultMovies = movies.filter({movie in return movie.title.contains(text)})
        }else {
            resultMovies = movies
        }
        tableView.reloadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier {
            let detailVC = segue.destination as! DetailViewController
            detailVC.movie = resultMovies[sender as! Int]
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        if resultMovies.count > 0 {
            cell.textLabel?.text = resultMovies[indexPath.row].title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: indexPath.row)
    }
}

