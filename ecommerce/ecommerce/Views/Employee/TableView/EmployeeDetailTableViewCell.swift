//
//  EmployeeDetailTableViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 26/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class EmployeeDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeDetailsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        employeeImageView.layer.cornerRadius = 40
        employeeImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
