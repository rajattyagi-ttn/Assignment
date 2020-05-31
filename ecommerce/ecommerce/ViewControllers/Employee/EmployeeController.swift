//
//  EmployeeController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 25/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class EmployeeController: UIViewController {

    @IBOutlet weak var listedView: UIView!
    @IBOutlet weak var detailedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listedView.isHidden = false
        detailedView.isHidden = true
        
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            listedView.isHidden = false
            detailedView.isHidden = true
        }
        else{
            listedView.isHidden = true
            detailedView.isHidden = false
        }
    }
    
}
