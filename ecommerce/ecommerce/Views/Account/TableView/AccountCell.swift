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
    @IBOutlet weak var additionalLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

 
    }
    
    func setupCell(indexPath: IndexPath) {
        self.menuItemImageView.image = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowIcon
        self.menuItemLabel.text = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName
        self.additionalLabel.isHidden = true
    }
    
}

