//
//  EmployeeListTableViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 26/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {


    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeIDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
