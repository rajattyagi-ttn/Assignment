//
//  RelatedCollectionViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 24/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class RelatedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
    }

}
