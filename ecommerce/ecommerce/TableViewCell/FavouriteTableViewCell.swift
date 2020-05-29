//
//  FavouriteTableViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 28/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var favouriteName: UILabel!
    @IBOutlet weak var favouriteRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
