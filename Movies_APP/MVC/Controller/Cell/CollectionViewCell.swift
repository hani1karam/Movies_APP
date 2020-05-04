//
//  CollectionViewCell.swift
//  Movies_APP
//
//  Created by Hany Karam on 5/3/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    func configure(movies: Result) {
        
        DispatchQueue.main.async {
            if let img = movies.posterPath{
                self.img.setImage(imageUrl: img)
            }
        }
    }
}
extension UIImageView {
    func setImage(imageUrl: String){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string:imageUrl), placeholder: nil, options: [.transition(.fade(0.7))],   completionHandler: nil)
    }
}
