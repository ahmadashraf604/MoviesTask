//
//  PhotoResponse.swift
//  Movies
//
//  Created by ashraf on 6/30/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation

// MARK: - PhotoResponse
struct PhotoResponse: Codable {
    let photos: PhotosDescription
    let stat: String
}
