//
//  LanguageCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 13/04/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var cellIconImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    
    let defaultLanguageName = "HINDI"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(indexPath: IndexPath) {
        self.cellIconImageView.image = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowIcon
        self.cellTitleLabel.text = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName
        self.languageNameLabel.text = String(defaultLanguageName.prefix(3))
    }
}
