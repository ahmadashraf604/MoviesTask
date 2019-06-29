//
//  HomePresenter.swift
//  Movies
//
//  Created by ashraf on 6/28/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation

class HomePresenter {
    
    var fileService = FileService()
    
    func getMovies() -> [Movie]? {
        return fileService.getMovies()
    }
}
