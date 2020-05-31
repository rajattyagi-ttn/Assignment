//
//  HomeCollectionViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 21/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showPopularityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outerView.layer.cornerRadius = 10
        outerView.clipsToBounds = true
        
        
    }

    
    func setPosterImage(image: UIImage) {
        showPosterImageView.image = image
    }
}
