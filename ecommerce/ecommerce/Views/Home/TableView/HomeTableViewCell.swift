//
//  HomeTableViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 21/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


// protocol to help in pushing viewcontrollers from nested collectionView cells
protocol CellDelegate {
    func showCellSelected(_ indexPath : IndexPath)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var showCategories = [[ShowsResultModel]]()
    var imageToSend: UIImage?
    var delegate : CellDelegate?

    
    static var isLoaded = false
    
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.showCategories = [[ShowsResultModel](),[ShowsResultModel](),[ShowsResultModel](),[ShowsResultModel]()]
        //Best Drama Api call
        getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66", index: 0)
        //Popular Api call
        getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66", index: 1)
        //Kids Api call
        getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66", index: 2)
        //In theatre Api call
        getShowsFrom(url: "https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2018-09-15&primary_release_date.lte=2018-10-22&api_key=820016b7116f872f5f27bf56f9fdfb66", index: 3)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib.init(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "showsCVCell")

    }

    //MARK:- Function to get shows From API Call
    func getShowsFrom(url: String, index: Int) {
            
            
            let request = AF.request(url)
                    
            request.responseDecodable(of: ShowsBaseModel.self) { (response) in
              
                guard let showData = response.value else { return }
                
                self.showCategories[index] = showData.results!
                self.collectionView.reloadData()
            }
        }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showsCVCell", for: indexPath) as! HomeCollectionViewCell
        //MARK:- Only assign value if Data is loaded
        if showCategories.count > 3 && showCategories[0].count>0 && showCategories[1].count>0 && showCategories[2].count>0 && showCategories[3].count>0 {
            
            let show = showCategories[collectionView.tag][indexPath.row]
            if show.name != nil {
                cell.showNameLabel.text = show.name?.uppercased()
            }
            else{
                cell.showNameLabel.text = show.title?.uppercased()
            }
            cell.showPopularityLabel.text = show.voteAverage?.description

            //MARK:- check for  poster path
            if show.posterPath == nil {
                cell.showPosterImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
            
            else {
                AF.request(baseImageUrl + (show.posterPath!)).responseImage { response in

                    if case .success(let image) = response.result {
                        cell.showPosterImageView.image = image
                        cell.showPosterImageView.contentMode = .scaleAspectFill
                    }
                }
            }
            // Applying Theme on CollectionViewCell
            
           
            if Theme.Fonts.fontColor() == UIColor.init(red: 0, green: 0, blue: 0, alpha: 1) {
               
                cell.innerView.backgroundColor = UIColor.white
                cell.showNameLabel.textColor = UIColor.black
                cell.showPopularityLabel.textColor = UIColor.black
                cell.showGenreLabel.textColor = UIColor.black
                cell.dolbyImageView.image = #imageLiteral(resourceName: "DolbyDigital")
                
            }
            else {
                
                let color = HexToUIColor.hexStringToUIColor(hex: "1F2124")
                cell.innerView.backgroundColor = color
                cell.showNameLabel.textColor = UIColor.white
                cell.showPopularityLabel.textColor = UIColor.white
                cell.showGenreLabel.textColor = UIColor.white
            }
            
            return cell
        }
        // if data is not loaded then return cell with placeholders
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showsCVCell", for: indexPath) as! HomeCollectionViewCell
            cell.showNameLabel.text = "Loading..."
            cell.showPopularityLabel.text = "Loading..."
            
            // Applying Theme on CollectionViewCell

            
            
            if Theme.Fonts.fontColor() == UIColor.init(red: 0, green: 0, blue: 0, alpha: 1) {
                
                cell.innerView.backgroundColor = UIColor.white
                cell.showNameLabel.textColor = UIColor.black
                cell.showPopularityLabel.textColor = UIColor.black
                cell.showGenreLabel.textColor = UIColor.black
                cell.dolbyImageView.image = #imageLiteral(resourceName: "DolbyDigital")
                
            }
            else {
                
                let color = HexToUIColor.hexStringToUIColor(hex: "1F2124")
                cell.innerView.backgroundColor = color
                cell.showNameLabel.textColor = UIColor.white
                cell.showPopularityLabel.textColor = UIColor.white
                cell.showGenreLabel.textColor = UIColor.white
                
            }

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = showCategories[collectionView.tag][indexPath.row]
        var array = showCategories[collectionView.tag]
        array.remove(at: indexPath.row)
        let relatedArray = array
        var imageUrl : String?
        
        if selectedItem.posterPath == nil {
            imageUrl = nil
        }
        else{
            imageUrl = baseImageUrl + selectedItem.posterPath!
        }

        MovieDetailsController.recievedSelectedShow = selectedItem
        MovieDetailsController.recievedShowId = selectedItem.id
        MovieDetailsController.recievedImageUrl = imageUrl
        MovieDetailsController.recievedRelatedShowsArray = relatedArray

        delegate?.showCellSelected(indexPath)

        
    }
    
}


