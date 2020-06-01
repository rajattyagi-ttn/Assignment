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
    
     var employeeImages = [#imageLiteral(resourceName: "employee1"),#imageLiteral(resourceName: "employee4"),#imageLiteral(resourceName: "employee3"),#imageLiteral(resourceName: "employee2")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        employeeImageView.layer.cornerRadius = 40
        employeeImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func setupCell(_ employeeInfo: EmployeeResultModel) {
        let number = Int.random(in: 0 ... 3)
        self.employeeImageView.image = employeeImages[number]
        
        self.employeeNameLabel.text = "\(employeeInfo.employeeName)  •  \(employeeInfo.employeeAge)"
        
        self.employeeDetailsLabel.text = "ID : \(employeeInfo.id)  Salary : ₹ \(employeeInfo.employeeSalary) "
    }
    
}
