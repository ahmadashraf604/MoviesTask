//
//  HomeTableViewController.swift
//  Movies
//
//  Created by ashraf on 7/1/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    //   MARK: properties
    var presenter = HomePresenter()
    var movies = [Movie]()
    var resultMovies = [[Movie]]()
    var searchFlage = false
    var detailSegueIdentifier = "showMovieDetails"
    
    //    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        if let returnedMovies = presenter.getMovies() {
            movies = returnedMovies
        }else{
            print("no movies found")
        }
        showSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    //  MARK: - TableView Configration
    override func numberOfSections(in tableView: UITableView) -> Int {
        // no search
        if !searchFlage {
            return 1
        }
        // return number of category by year
        return resultMovies.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchFlage {
            return movies.count
        }
        //return number of cell in this category
        return resultMovies[section].count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !searchFlage {
            return nil
        }
        return String(resultMovies[section][0].year)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        var movieTitle: String!
        if !searchFlage {
            movieTitle = movies[indexPath.row].title
        }else {
            movieTitle = resultMovies[indexPath.section][indexPath.row].title
        }
        cell.textLabel?.text = movieTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var movie: Movie!
        if !searchFlage {
            movie = movies[indexPath.row]
        }else{
            movie = resultMovies[indexPath.section][indexPath.row]
        }
        performSegue(withIdentifier: detailSegueIdentifier, sender: movie)
    }
    //  MARK: - navigation control
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier {
            let detailVC = segue.destination as! DetailViewController
            detailVC.movie = sender as! Movie
        }
    }
    
    //  MARK: - serch control
    func showSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.isActive = true
        search.definesPresentationContext = true
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
}

extension HomeTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 0 {
            searchFlage = true
            let result = movies.filter({movie in return movie.title.lowercased().contains(text.lowercased())}).sorted(by: {$0.rating > $1.rating})
            let category =  result.reduce(into: ([:]), {$0[$1.year, default: 0] += 1})
            resultMovies.removeAll()
            for item in category {
                resultMovies.append(Array(result.filter({$0.year == item.key}).prefix(5)))
            }
        }else {
            searchFlage = false
        }
        tableView.reloadData()
    }
}

