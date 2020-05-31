//
//  FontStyleController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 31/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class FontStyleController: UIViewController {

    @IBOutlet weak var fontsTableView: UITableView!
    
    var fonts : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            self.fontsTableView.dataSource = self
            self.fontsTableView.delegate = self
            for family: String in UIFont.familyNames {
               //print(family)
               for names: String in UIFont.fontNames(forFamilyName: family)
               {
                   fonts.append(names)
               }
            }
        }

}

extension FontStyleController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fontsTableView.dequeueReusableCell(withIdentifier: "fontsCell", for: indexPath)
        cell.textLabel?.text = fonts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(fonts[indexPath.row], forKey: "font")
        Theme.updateDisplay()
        self.navigationController?.popViewController(animated: true)
    }
    
}
