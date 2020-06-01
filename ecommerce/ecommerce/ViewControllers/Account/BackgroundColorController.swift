//
//  BackgroundColorController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 31/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class BackgroundColorController: UIViewController {

    @IBOutlet weak var colorPickerView: UIView!
    
    let colorPicker = SwiftHSVColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        colorPickerView.addSubview(colorPicker)
        colorPicker.setViewColor(UIColor.red)
    }
    
 
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        UserDefaults.standard.set(ColorToHex.hexStringFromColor(color: colorPicker.color), forKey: "backgroundColour")
        self.navigationController?.popViewController(animated: true)
    }
 
    

}
