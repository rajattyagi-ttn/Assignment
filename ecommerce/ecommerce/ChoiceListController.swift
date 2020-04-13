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
    
    let defaultCountryFlagImage = #imageLiteral(resourceName: "globe")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "ChoiceCell", bundle: nil)
        choiceListTableView.register(nib, forCellReuseIdentifier: "choicecell")
        
        let nib2 = UINib.init(nibName: "CountryListCell", bundle: nil)
        choiceListTableView.register(nib2, forCellReuseIdentifier: "countrylistcell")
    }

}

extension ChoiceListController : UITableViewDelegate, UITableViewDataSource {
    
    
    // This Function converts country code into it's respective flag emoji
    
    func countryCodeToFlag(from country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch AccountController.choice {
        case .country:
            return CountryList.countryItems.count
        
        case .language:
            return LanguageList.languageItem.count
        
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Configuring cell based on where user came from (Country or Language)
        
        switch AccountController.choice {
        case .country:
            let cell = choiceListTableView.dequeueReusableCell(withIdentifier: "countrylistcell", for: indexPath) as! CountryListCell
            cell.countryNameLabel.text = CountryList.countryItems[indexPath.row].countryName
            
            if let url = URL(string: "https://www.countryflags.io/\(CountryList.countryCodes[indexPath.row])/shiny/64.png") {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            
                            //here i pass image to cell.FlagImage
                            
                            cell.setCountryFlagImageView(image: UIImage(data: data) ?? self.defaultCountryFlagImage)
                            cell.countryFlagImageView.contentMode = .scaleAspectFill

                        }
                    }
                }.resume()
                
            }
            
            return cell
        
        default:
            let cell = choiceListTableView.dequeueReusableCell(withIdentifier: "choicecell", for: indexPath) as! ChoiceCell
            cell.countryNameLabel.text = "\(LanguageList.languageItem[indexPath.row].languageName)"
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if AccountController.choice == .country {
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

    
}
