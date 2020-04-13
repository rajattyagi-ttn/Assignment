//
//  CountryListCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 13/04/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class CountryListCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
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
