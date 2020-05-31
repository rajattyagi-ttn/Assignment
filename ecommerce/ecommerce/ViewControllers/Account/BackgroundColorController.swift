//
//  BackgroundColorController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 31/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class BackgroundColorController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        button1.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "d1e6d6")
        button2.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "d8f2ae")
        button3.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "c5ff66")
        button4.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "fffea6")
        button5.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "ffe0a6")
        button6.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "fcb48d")
        button7.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "ffffff")
        button8.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "8de4fc")
        button9.backgroundColor = HexToUIColor.hexStringToUIColor(hex: "000000")
        
        view.backgroundColor = UIColor.gray
    }
    

    @IBAction func backgroundColorButtonTapped(_ sender: UIButton) {
        
        if sender.tag == 0 {
            UserDefaults.standard.set("#d1e6d6", forKey: "backgroundColour")

        }
        else if sender.tag == 1 {
            UserDefaults.standard.set("#d8f2ae", forKey: "backgroundColour")

        }
        else if sender.tag == 2 {
            UserDefaults.standard.set("#c5ff66", forKey: "backgroundColour")

        }
        else if sender.tag == 3 {
            UserDefaults.standard.set("#fffea6", forKey: "backgroundColour")

        }
        else if sender.tag == 4 {
            UserDefaults.standard.set("#ffe0a6", forKey: "backgroundColour")

        }
        else if sender.tag == 5 {
            UserDefaults.standard.set("#fcb48d", forKey: "backgroundColour")

        }
        else if sender.tag == 6 {
            UserDefaults.standard.set("#ffffff", forKey: "backgroundColour")
        }
        else if sender.tag == 7 {
            UserDefaults.standard.set("#8de4fc", forKey: "backgroundColour")

        }
        else if sender.tag == 8 {
            UserDefaults.standard.set("#000000", forKey: "backgroundColour")

        }
        self.navigationController?.popViewController(animated: true)
    }
    

}
