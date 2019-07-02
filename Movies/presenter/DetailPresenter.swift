//
//  DetailPresenter.swift
//  Movies
//
//  Created by ashraf on 6/30/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation

class DetailPresenter {
    
    
    var networkService: NetworkService
    var detailDelegate: DetailDelegate
    
    init(detailDelegate: DetailDelegate) {
        self.detailDelegate = detailDelegate
        self.networkService = NetworkService()
    }
    
    func getPhotos(forMovie title: String) {
        networkService.getPhotos(forMovie: title, completionHandler: { photos in
            let photosUrl = self.getPhotosUrl(photos: photos)
            self.detailDelegate.setPhotos(url: photosUrl)
        }, errorHandler: { error in
            self.detailDelegate.displayNoData()
        })
    }
    
    private func getPhotosUrl(photos: [Photo]) -> [String] {
        var photosUrl = [String]()
        for i in 0 ..< photos.count {
            let photo = photos[i]
            photosUrl.append("https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")
        }
        return photosUrl
    }
}
