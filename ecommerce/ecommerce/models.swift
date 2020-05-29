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


class ShowsBaseModel: Codable {
    var page: Int?
    var results: [ShowsResultModel]?
    var totalPages: Int?
    var totalResults: Int?
    
    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

class ShowsResultModel: NSObject, Codable {
    static func == (lhs: ShowsResultModel, rhs: ShowsResultModel) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        else {
            return false
        }
    }
    
    var id: Int?
    var name: String?
    var title: String?
    var overView: String?
    var originalName: String?
    var posterPath: String?
    var voteAverage: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case overView = "overview"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

extension ShowsResultModel {
    func persist(using key: String) {
        do {
            let encodedShow = try JSONEncoder().encode(self)
            UserDefaults.standard.set(encodedShow, forKey: key)
        } catch {
            // in case of something wrong happened
            print(error.localizedDescription)
        }
    }
    
    static func fetch(using key: String) -> ShowsResultModel? {
        do {
            guard let persistedShow = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
            let decodedShow = try JSONDecoder().decode(ShowsResultModel.self, from: persistedShow)
            return decodedShow
        } catch {
            // in case of something wrong happened
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Array where Element == ShowsResultModel {
    func persist(using key: String) {
        do {
            let encodedShow = try JSONEncoder().encode(self)
            UserDefaults.standard.set(encodedShow, forKey: key)
        } catch {
            // in case of something wrong happened
            print(error.localizedDescription)
        }
    }
    
    static func fetch(using key: String) -> [ShowsResultModel]? {
        do {
            guard let persistedShowes = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
            let decodedShowes = try JSONDecoder().decode([ShowsResultModel].self, from: persistedShowes)
            return decodedShowes
        } catch {
            // in case of something wrong happened
            print(error.localizedDescription)
            return nil
        }
    }
}

struct EmployeeBaseModel: Decodable {
    var status: String
    var data: [EmployeeResultModel]
}


struct EmployeeResultModel: Codable {
    
    let id: String
    let employeeName: String
    let employeeSalary: String
    let employeeAge: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
    }
    
}



struct showDetailBaseModel: Codable {
    let genres: [showDetailResultModel]
}

struct showDetailResultModel: Codable {
    let id: String
    let name: String
}

var movieGenre = [28:"Action", 12:"Adventure",16:"Animation",35:"Comedy",80:"Crime",99:"Documentary",18:"Drama",10751:"Family", 14:"Fantasy", 36:"History", 27:"Horror",10402:"Music"]

enum CellMode {
    case country
    case language
    case none
}
