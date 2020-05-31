//
//  ShowModel.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 30/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation

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
        if lhs.id == rhs.id {
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



//MARK:- Extension for storing ShowsResultModel array in userDefaults
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
