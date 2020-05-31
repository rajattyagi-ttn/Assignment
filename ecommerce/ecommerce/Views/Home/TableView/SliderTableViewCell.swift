//
//  SliderTableViewCell.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 23/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SliderTableViewCell: UITableViewCell {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var sliderPageController: UIPageControl!
    
    var trendingShows = [ShowsResultModel]()
    var cellDelegate : CellDelegate?

    var timer = Timer()
    var counter = 0
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        sliderCollectionView.backgroundColor = Theme.color(type: .backgroundColor)
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
            
        let nib = UINib(nibName: "SliderCollectionViewCell", bundle: nil)
       sliderCollectionView.register(nib, forCellWithReuseIdentifier: "sliderCVCell")
        
        // Trending Api Call
        getShowsFrom(url: "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66")
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    // Function to change Slider Image Automatically
    @objc func changeImage() {
        
        if counter<trendingShows.count {
         
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            sliderPageController.currentPage = counter
            counter += 1
        }
        else {
            
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            sliderPageController.currentPage = counter
            counter = 1
        }
        
    }
    
    // Function to get API data from URL
    
    func getShowsFrom(url: String) {

        let request = AF.request(url)
                
        request.responseDecodable(of: ShowsBaseModel.self) { (response) in
          
            guard let showData = response.value else { return }

            self.trendingShows = showData.results!

            self.sliderCollectionView.reloadData()
        }
        
    }
    
}

extension SliderTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trendingShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
           let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "sliderCVCell", for: indexPath) as! SliderCollectionViewCell
                      
                
            if trendingShows[indexPath.row].posterPath == nil {
                cell.sliderImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
            else{
            AF.request("https://image.tmdb.org/t/p/w500\(trendingShows[indexPath.row].posterPath!)").responseImage { response in
                
                    if case .success(let image) = response.result {
                        cell.sliderImageView.image = image
                      cell.sliderImageView.contentMode = .scaleAspectFill
                    }
                }
            }
        
            return cell
        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 415, height: sliderCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = trendingShows[indexPath.row]
        var array = trendingShows
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
        
        
        cellDelegate?.showCellSelected(indexPath)
    }
    
}
