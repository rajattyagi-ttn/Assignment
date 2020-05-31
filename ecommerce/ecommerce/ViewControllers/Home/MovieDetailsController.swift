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

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    @IBOutlet weak var showDetailsTextView: UITextView!
    @IBOutlet weak var showGenresLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var recievedRelatedShowsArray: [ShowsResultModel]?
    static var recievedSelectedShow: ShowsResultModel?
    static var recievedPosterImage: UIImage?
    static var recievedImageUrl: String?
    static var recievedShowId: Int?
    
    var showGenres: [String] = []
    var isFavourite = false
    var favouriteList = [ShowsResultModel]()
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShowGenres(url: "https://api.themoviedb.org/3/movie/\(MovieDetailsController.recievedShowId!)?api_key=820016b7116f872f5f27bf56f9fdfb66&language=en-US")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchingFavourites()
        setupMoviesDetails()

        let nib = UINib(nibName: "RelatedCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "relatedCVCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupTheme()
        
    }
    
    func setupTheme() {
        view.backgroundColor = Theme.color(type: .backgroundColor)
        contentView.backgroundColor = Theme.color(type: .backgroundColor)
        
        if UserDefaults.standard.object(forKey: "brandColour") != nil {
            playButton.backgroundColor = Theme.color(type: .brandColor)
        }
        
        if UserDefaults.standard.object(forKey: "fontColor") != nil {
            playButton.setTitleColor(Theme.Fonts.fontColor(), for: .normal)
        }
        
        if UserDefaults.standard.object(forKey: "font") != nil {
           playButton.titleLabel?.font = Theme.Fonts.font()
       }
        
    }
    
    //MARK:- Function to check if selected item in in array or not
    func contain(obj: ShowsResultModel, in array: [ShowsResultModel]) -> Bool {
        for i in 0..<array.count {
            if obj.id == array[i].id {
                return true
            }
        }
        return false
    }
    
    //MARK:- Getting Favourite list from userDefaults
    func fetchingFavourites() {
        if UserDefaults.standard.object(forKey: "favList") != nil {
            // fetching
            if let fetchedArray = Array.fetch(using: "favList") {
                favouriteList = fetchedArray

                let doesContain = contain(obj: MovieDetailsController.recievedSelectedShow!, in: favouriteList)
                if doesContain == true {

                    favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    isFavourite = true
                }
                else {
                    
                    favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    isFavourite = false
                }
            }
        
        }
    }

    //MARK:- function to set details recieved from previous controller
    func setupMoviesDetails() {
        if MovieDetailsController.recievedSelectedShow?.name != nil {
            self.showNameLabel.text = MovieDetailsController.recievedSelectedShow?.name?.uppercased()
        }
        else {
            self.showNameLabel.text = MovieDetailsController.recievedSelectedShow?.title?.uppercased()
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
    }
    //MARK:- Function to get Genres of selected show
    func getShowGenres(url: String) {

        var array = [String]()
        let request = AF.request(url)
        request.responseJSON(completionHandler: { (data) in
            
            if case .success( _) = data.result {

                guard let jsonResult = try? JSONSerialization.jsonObject(with: data.data!, options: .mutableContainers) as! [String: AnyObject]  else {
                    print("fail")
                    return
                }

                guard let genres = jsonResult["genres"] as? NSArray else { return }

                for i in 0..<genres.count {
                    let genre = genres[i] as! NSDictionary
                    if let genreName = genre["name"] {
                        array.append(genreName as! String)
                    }
               }
                var genreString = ""
                if array.count > 0 {
                    genreString = array[0]
                    for i in 1..<array.count {
                        
                        genreString = genreString + " | \(array[i])"
                     
                    }
                    
                    DispatchQueue.main.async {
                        self.showGenresLabel.text = genreString.uppercased()
                    }
                }
            }
        })
        
    }
    
    //MARK:- Function to remove Element from Array
    func removeElement(element: ShowsResultModel, from Array: inout [ShowsResultModel]) -> Int {
        for i in 0..<Array.count {
            if Array[i].id == element.id {
                Array.remove(at: i)
                return i
            }
        }
        return -1
    }
    
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            removeElement(element: MovieDetailsController.recievedSelectedShow!, from: &favouriteList)
            isFavourite = false
        }
        
        else {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favouriteList.append(MovieDetailsController.recievedSelectedShow!)
            isFavourite = true
        }
        
        favouriteList.persist(using: "favList")
       

        favouriteButton.contentMode = .scaleAspectFit
    }
    
}

extension MovieDetailsController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MovieDetailsController.recievedRelatedShowsArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "relatedCVCell", for: indexPath) as! RelatedCollectionViewCell
        
        let show = MovieDetailsController.recievedRelatedShowsArray?[indexPath.row]
        
        if show?.posterPath == nil {
            cell.imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        }
        
        else {
            AF.request(baseImageUrl + (show!.posterPath!)).responseImage { response in

                if case .success(let image) = response.result {
                    cell.imageView.image = image
                    cell.imageView.contentMode = .scaleAspectFill
                }

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
        
        var imageUrl : String?
        
        if selectedItem?.posterPath == nil {
            imageUrl = nil
        }
        else{
            imageUrl = baseImageUrl + (selectedItem?.posterPath!)!
        }
        
        MovieDetailsController.recievedSelectedShow = selectedItem
        MovieDetailsController.recievedShowId = selectedItem?.id
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

