//
//  DetailViewController.swift
//  Movies
//
//  Created by ashraf on 6/29/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailDelegate {
    
    var presenter: DetailPresenter!
    var photosUrl = [String](){
        didSet {
            posterCollectionView.reloadData()
            self.posterCollectionView?.layoutIfNeeded()
            self.posterCollectionViewHeight?.constant = (self.posterCollectionView?.contentSize.height)!
        }
    }
    var movie: Movie! {
        didSet {
            // update user interface
            updateView()
        }
    }
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    @IBOutlet weak var castTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var genreTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var posterCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var realseYearLabel: UILabel!
    @IBOutlet weak var genreTableView: UITableView!
    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = DetailPresenter(detailDelegate: self)
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getPhotos(forMovie: movie.title)
    }
    func updateView() {
        if let newMovie = movie {
            titleLabel?.text = newMovie.title
            realseYearLabel?.text = String(newMovie.year)
            
            self.genreTableView?.reloadData()
            self.genreTableView?.layoutIfNeeded()
            self.genreTableViewHeight?.constant = (self.genreTableView?.contentSize.height)!
            self.castTableView?.reloadData()
            self.castTableView?.layoutIfNeeded()
            self.castTableViewHeight?.constant = (self.castTableView?.contentSize.height)!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === genreTableView {
            return movie.genres.count
        } else if tableView === castTableView {
            return movie.cast.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === self.genreTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath)
            cell.textLabel?.text = movie.genres[indexPath.row].rawValue
            return cell
        } else if tableView === self.castTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath)
            cell.textLabel?.text = movie.cast[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func setPhotos(url: [String]) {
        photosUrl = url
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! DetailCollectionViewCell
        cell.image = photosUrl[indexPath.row]
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 , height: collectionView.bounds.width / 2)
    }
}


