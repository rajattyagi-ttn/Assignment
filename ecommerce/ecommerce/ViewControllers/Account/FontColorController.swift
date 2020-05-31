//
//  FontColorController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 31/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class FontColorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func fontColorButtonTapped(_ sender: UIButton) {
        
        if sender.tag == 0 {
            UserDefaults.standard.set("#ffffff", forKey: "fontColor")
            
        }
        else if sender.tag == 1 {
            UserDefaults.standard.set("#000000", forKey: "fontColor")
        }
        
        Theme.updateFontColor()
        self.navigationController?.popViewController(animated: true)

    }
    
}
