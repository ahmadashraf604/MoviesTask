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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(presenter.getMovies()!)
    }

}

