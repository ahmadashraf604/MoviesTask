//
//  Movie.swift
//  Movies
//
//  Created by ashraf on 6/28/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation


struct MovieJson: Codable {
    let movies: [Movie]
}

struct Movie: Codable {
    let title: String
    let year: Int
    let cast: [String]
    let genres: [Genre]
    let rating: Int
}
