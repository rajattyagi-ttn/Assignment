//
//  FavouriteController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 28/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire

class FavouriteController: UIViewController {


    @IBOutlet weak var favouriteTableView: UITableView!
    
    var favouriteArray = [ShowsResultModel]()
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "favList") != nil {
        // fetching
        if let fetchedArray = Array.fetch(using: "favList") {
            favouriteArray = fetchedArray
            }
        }
  
        
        let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
        favouriteTableView?.register(nib, forCellReuseIdentifier: "favouriteTVCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {

        DispatchQueue.main.async {

            self.favouriteTableView?.reloadData()

        }
    }


}

extension FavouriteController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTableView.dequeueReusableCell(withIdentifier: "favouriteTVCell", for: indexPath) as! FavouriteTableViewCell
        if favouriteArray[indexPath.row].name != nil {
            cell.favouriteName.text = favouriteArray[indexPath.row].name
        }
        else {
            cell.favouriteName.text = favouriteArray[indexPath.row].title
        }
        cell.favouriteRating.text = favouriteArray[indexPath.row].voteAverage?.description
        
        AF.request(baseImageUrl + (favouriteArray[indexPath.row].posterPath ?? "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")).responseImage { response in

            if case .success(let image) = response.result {
                cell.favouriteImageView.image = image
                cell.favouriteImageView.contentMode = .scaleAspectFill
            }

        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


