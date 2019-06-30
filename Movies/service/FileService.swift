//
//  FileService.swift
//  Movies
//
//  Created by ashraf on 6/28/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import Foundation

class FileService {
    
    func getMovies() -> [Movie]? {
        let url = Bundle.main.url(forResource: "movies", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            do{
                let json =  try JSONDecoder().decode(MovieJson.self, from: jsonData)
                return json.movies
            }catch {
                print(error)
                return nil
            }
        }
        catch {
            print(error)
            return nil
        }
    }
}
