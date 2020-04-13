//
//  CountryCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 13/04/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var cellIconImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCountryFlagImageView(image: UIImage) {
        countryFlagImageView.image = image
    }
    
}
