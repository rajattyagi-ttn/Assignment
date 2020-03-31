//
//  AccountCell.swift
//  ecommerceTests
//
//  Created by Rajat Tyagi on 20/03/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!

    @IBOutlet weak var additionalLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        countryPicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50)
//        countryPicker.isHidden = true
        
        
//        countryPicker.delegate = self
//        countryPicker.dataSource = self
//        additionalTextfield.inputView = countryPicker
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

 
    }
    
}

