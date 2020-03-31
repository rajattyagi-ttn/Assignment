//
//  CountryListController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 26/03/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class ChoiceListController: UIViewController {

    @IBOutlet weak var choiceListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "ChoiceCell", bundle: nil)
        choiceListTableView.register(nib, forCellReuseIdentifier: "choicecell")
    }

}

extension ChoiceListController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CountryList.countryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if AccountController.choice == "country" {
            let cell = choiceListTableView.dequeueReusableCell(withIdentifier: "choicecell", for: indexPath) as! ChoiceCell
            let flagCodeString = CountryList.countryCodes[indexPath.row]
            let flagString = countryCodeToFlag(from: flagCodeString)
            cell.countryNameLabel.text = flagString + " \(CountryList.countryItems[indexPath.row].countryName)"
            return cell
        }
        else {
            let cell = choiceListTableView.dequeueReusableCell(withIdentifier: "choicecell", for: indexPath) as! ChoiceCell
            cell.countryNameLabel.text = "\(LanguageList.languageItem[indexPath.row].languageName)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if AccountController.choice == "country" {
            let countryCodeString = CountryList.countryCodes[indexPath.row]
            let flagString = countryCodeToFlag(from: countryCodeString)
            AccountController.recievedCountry = flagString
            AccountController.recievedCountry! += " \(countryCodeString)"
        }
        else{
            let languageCodeString = LanguageList.languageCodes[indexPath.row]
            AccountController.recievedLanguage = languageCodeString
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    
    // This Function converts country code into it's flag emoji
    
    func countryCodeToFlag(from country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
        
        
    }
    
   
    
    
}
