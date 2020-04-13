//
//  models.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 20/03/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit


 struct AccountMenu {
    var rowIcon : UIImage
    var rowName : String
    var country : String?
    var language : String?
    
    public static var accountMenuItems : [[AccountMenu]] = [
        [AccountMenu(rowIcon: #imageLiteral(resourceName: "location"), rowName: "Track Order"),
        AccountMenu(rowIcon: #imageLiteral(resourceName: "sizeChart"), rowName: "Size Chart"),
        AccountMenu(rowIcon: UIImage(systemName: "bell")!, rowName: "Notifications"),
        AccountMenu(rowIcon: #imageLiteral(resourceName: "cross"), rowName: "Store Locator"),],
        [AccountMenu(rowIcon: #imageLiteral(resourceName: "globe"), rowName: "Country",country: "AED"),
        AccountMenu(rowIcon: #imageLiteral(resourceName: "language"), rowName: "Language", language: "ENG"),
        AccountMenu(rowIcon: UIImage(systemName: "person")!, rowName: "About Us"),
        AccountMenu(rowIcon: #imageLiteral(resourceName: "FAQ"), rowName: "FAQ"),
        AccountMenu(rowIcon: #imageLiteral(resourceName: "Shipping"), rowName: "Shipping & Returns"),]

    ]
    
}



 struct CountryList {
    
    var countryName : String
    
    // Computed property for country List Array
    
    public static var countryItems: [CountryList] {
        var listOfCountry : [String] = []
        var countryItemArray : [CountryList] = []
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            listOfCountry.append(name)
        }
        for i in 0..<listOfCountry.count {
            let countryObj = CountryList(countryName: "\(listOfCountry[i])")
            countryItemArray.append(countryObj)
        }
        return countryItemArray
    }
    
    // Computed property for country codes
    public static var countryCodes : [String] {
        var listOfCodes : [String] = []
        for code in NSLocale.isoCountryCodes as [String] {
            listOfCodes.append(code)
        }
        return listOfCodes
    }
    
}


struct LanguageList {
    
    var languageName : String
    
    public static var languageItem : [LanguageList] {
        var listOfLanguages : [String] = []
        var languageItemArray : [LanguageList] = []
        
        for code in NSLocale.isoLanguageCodes as [String] {
           let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.languageCode.rawValue: code])
           let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "\(code)"
           listOfLanguages.append(name)
       }
        for i in 0..<listOfLanguages.count {
           let languageObj = LanguageList(languageName: "\(listOfLanguages[i])")
           languageItemArray.append(languageObj)
       }
       return languageItemArray
    }
    
    public static var languageCodes : [String] {
        var listOfCodes : [String] = []
        for code in NSLocale.isoLanguageCodes as [String] {
            listOfCodes.append(code)
        }
        return listOfCodes
    }
}

enum CellMode {
    case country
    case language
    case none
}
