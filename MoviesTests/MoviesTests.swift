//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by ashraf on 6/28/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {
    
    func testGetMovies() {
        let homePresenter = HomePresenter()
        let movies = homePresenter.getMovies()
        XCTAssert(movies != nil)
    }
    
}
