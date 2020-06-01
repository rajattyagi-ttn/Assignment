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
    
    let defaultCountryCode = "in"
    let defaultCountryFlagImage = #imageLiteral(resourceName: "globe")
    
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
    
    func setupCell(indexPath: IndexPath) {
        self.cellIconImageView.image = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowIcon
        self.cellTitleLabel.text = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName
        self.countryNameLabel.text = defaultCountryCode.uppercased()
        
        if let url = URL(string: "https://www.countryflags.io/\(defaultCountryCode)/shiny/64.png") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        
                        self.setCountryFlagImageView(image: UIImage(data: data) ?? self.defaultCountryFlagImage)
                        self.countryFlagImageView.contentMode = .scaleAspectFill

                    }
                }
            }.resume()
            
        }
        
    }
    
}
