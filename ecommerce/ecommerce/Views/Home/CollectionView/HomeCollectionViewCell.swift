//
//  HomeCollectionViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 21/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showPopularityLabel: UILabel!
    @IBOutlet weak var showGenreLabel: UILabel!
    @IBOutlet weak var dolbyImageView: UIImageView!
    
    
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        outerView.layer.cornerRadius = 10
        outerView.clipsToBounds = true
        

    }

    func setPosterImage(image: UIImage) {
        showPosterImageView.image = image
    }
        
        
        func setupCell(_ showInfoCell: ShowsResultModel) {
            if showInfoCell.name != nil {
                self.showNameLabel.text = showInfoCell.name?.uppercased()
            }
            else{
                self.showNameLabel.text = showInfoCell.title?.uppercased()
            }
            self.showPopularityLabel.text = showInfoCell.voteAverage?.description

            //MARK:- check for  poster path
            if showInfoCell.posterPath == nil {
                self.showPosterImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
            
            else {
                AF.request(baseImageUrl + (showInfoCell.posterPath!)).responseImage { response in

                    if case .success(let image) = response.result {
                        self.showPosterImageView.image = image
                        self.showPosterImageView.contentMode = .scaleAspectFill
                    }
                }
            }
        }
}
