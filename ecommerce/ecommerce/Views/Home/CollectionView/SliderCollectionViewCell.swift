//
//  SliderCollectionViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 23/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sliderImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        sliderImageView.layer.cornerRadius = 10
        sliderImageView.clipsToBounds = true
    }

}
