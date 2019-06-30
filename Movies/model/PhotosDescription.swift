//
//  PhotosDescription.swift
//  Movies
//
//  Created by ashraf on 6/30/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation

// MARK: - Photos
struct PhotosDescription: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}
