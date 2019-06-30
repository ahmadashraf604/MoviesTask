//
//  Photo.swift
//  Movies
//
//  Created by ashraf on 6/30/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
