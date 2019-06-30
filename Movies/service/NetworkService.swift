//
//  NetworkService.swift
//  Movies
//
//  Created by ashraf on 6/29/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    private let api_key = "4a8ce0be790e4b9f0b70ce8166aafa7a"
    private let baseUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&per_page=10&page=1&format=json&nojsoncallback=1"
    
    func getPhotos(forMovie title: String, completionHandler: @escaping ([Photo]) -> Void, errorHandler: @escaping (String) -> Void) {
        let url = "\(baseUrl)&api_key=\(api_key)&text=\(title)"
        Alamofire.request(url).responseJSON { (responseObject) -> Void in
            
            switch responseObject.result {
            case .success(_) :
                do{
                    let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: responseObject.data!)
                    if photoResponse.stat == "ok" {
                        completionHandler(photoResponse.photos.photo)
                    }else{
                        errorHandler("No photo found")
                    }
                }catch{
                    errorHandler("error in parse")
                }
            case .failure(let error) :
                errorHandler("network error \(error)")
            }
            
        }
    }
}
