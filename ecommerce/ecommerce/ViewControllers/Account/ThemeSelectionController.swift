//
//  ThemeSelectionController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 31/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class ThemeSelectionController: UIViewController {

    @IBOutlet weak var brandColorButton: UIButton!
    @IBOutlet weak var fontsButton: UIButton!
    @IBOutlet weak var backgroundColorButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "brandColour") == nil {
            UserDefaults.standard.set("#32a852", forKey: "brandColour")
        }
        if UserDefaults.standard.object(forKey: "backgroundColour") == nil {
            UserDefaults.standard.set("#00000", forKey: "backgroundColour")
        }
        
        if UserDefaults.standard.object(forKey: "font") == nil {
            UserDefaults.standard.set("Verdana-Bold", forKey: "font")
        }
        
        if UserDefaults.standard.object(forKey: "fontColor") == nil {
            UserDefaults.standard.set("#000000", forKey: "fontColor")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.color(type: .backgroundColor)
        backgroundColorButton.backgroundColor = Theme.color(type: .brandColor)
        brandColorButton.backgroundColor = Theme.color(type: .brandColor)
        fontsButton.backgroundColor = Theme.color(type: .brandColor)
        fontsButton.titleLabel?.font = Theme.Fonts.font()
        fontsButton.tintColor = Theme.Fonts.fontColor()
    }
    

    @IBAction func backgroundColorButtonTapped(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "BackgroundColorController") as! BackgroundColorController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func brandColorButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func fontsButtonTapped(_ sender: UIButton) {
    }
    
}
