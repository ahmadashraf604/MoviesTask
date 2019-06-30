//
//  DetailCollectionViewCell.swift
//  Movies
//
//  Created by ashraf on 6/30/19.
//  Copyright © 2019 Ashraf. All rights reserved.
//

import UIKit
import SDWebImage

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image:String! {
        didSet {
            imageView.sd_setImage(with: URL(string: image), completed: nil)
        }
    }
}
