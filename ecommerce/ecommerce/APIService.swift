//
//  APIService.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 20/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage




class APIService {
    
 
    var imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    var responseModel: ShowsBaseModel?
    
    typealias showsCallBack = (_ shows:[ShowsResultModel]?,_ status:Bool, _ message: String) -> Void
    var callBack: showsCallBack?
    
     func getShowsFrom(url: String) {
             
             
         
     AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {  (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil,false,"")
                return }
            do {

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let result = try decoder.decode(ShowsBaseModel.self, from: data)
//                showArray = result.results!
                self.responseModel = result
                self.callBack?(self.responseModel?.results,true,"")
            }
            catch{
                self.callBack?(nil,false,error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callBack: @escaping showsCallBack) {
        self.callBack = callBack
    }
    
}

