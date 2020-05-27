//
//  MovieDetailsController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 24/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

//protocol ShowDetailsDelegate {
//    func setValues(posterImage: UIImage, name: String, rating: Double, details: String, relatedShows: [ResultModel], selectedShow: ResultModel)
//}

class MovieDetailsController: UIViewController {

    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
//    @IBOutlet weak var showDetailsLabel: UILabel!
    @IBOutlet weak var showDetailsTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var recievedRelatedShowsArray: [ShowsResultModel]?
    static var recievedSelectedShow: ShowsResultModel?
    static var recievedPosterImage: UIImage?
    static var recievedImageUrl: String?
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        if MovieDetailsController.recievedSelectedShow?.name != nil {
            self.showNameLabel.text = MovieDetailsController.recievedSelectedShow?.name
        }
        else {
            self.showNameLabel.text = MovieDetailsController.recievedSelectedShow?.title
        }
        self.showDetailsTextView.text = MovieDetailsController.recievedSelectedShow?.overView
        self.showRatingLabel.text = (MovieDetailsController.recievedSelectedShow?.voteAverage?.description)! + "/10"
        
        if(MovieDetailsController.recievedImageUrl != nil) {
            AF.request(MovieDetailsController.recievedImageUrl!).responseImage { response in

                           if case .success(let image) = response.result {
                               self.showPosterImageView.image = image
                               self.showPosterImageView.contentMode = .scaleAspectFill
                       }

                   }
        }
        else {
            self.showPosterImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        }
       
        
        let nib = UINib(nibName: "RelatedCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "relatedCVCell")
        
    }

}

extension MovieDetailsController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MovieDetailsController.recievedRelatedShowsArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "relatedCVCell", for: indexPath) as! RelatedCollectionViewCell
        
        let show = MovieDetailsController.recievedRelatedShowsArray?[indexPath.row]
        AF.request(baseImageUrl + (show?.posterPath ?? "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")).responseImage { response in

            if case .success(let image) = response.result {
                cell.imageView.image = image
                cell.imageView.contentMode = .scaleAspectFill
            }

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = MovieDetailsController.recievedRelatedShowsArray?[indexPath.row]
        var array = MovieDetailsController.recievedRelatedShowsArray!
        array.remove(at: indexPath.row)
        array.append(MovieDetailsController.recievedSelectedShow!)
        let relatedArray = array
        
        let imageUrl = baseImageUrl + (selectedItem?.posterPath ?? "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")
        
        MovieDetailsController.recievedSelectedShow = selectedItem
        MovieDetailsController.recievedImageUrl = imageUrl
        MovieDetailsController.recievedRelatedShowsArray = relatedArray
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsController") as! MovieDetailsController
//        self.navigationController?.pushViewController(vc, animated: true)
        self.viewDidLoad()
        self.viewWillAppear(true)
    
        self.collectionView.reloadData()
    }
    
    
}








//extension MovieDetailsController: ShowDetailsDelegate {
//    func setValues(posterImage: UIImage, name: String, rating: Double, details: String, relatedShows: [ResultModel], selectedShow: ResultModel) {
//        self.showPosterImageView.image = posterImage
//        self.showNameLabel.text = name
//        self.showDetailsLabel.text = details
//        self.showRatingLabel.text = rating.description
//        self.relatedShowsArray = relatedShows
//        self.selectedShow = selectedShow
//    }
//
    
    
    
//}
