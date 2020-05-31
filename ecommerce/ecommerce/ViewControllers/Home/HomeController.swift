//
//  HomeController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 20/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var sectionsTitle = ["Trending","Best Drama","Popular","Kids","In Theatre"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "showsTVCell")
        
        let nib2 = UINib(nibName: "SliderTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "sliderTVCell")
        
    }
   

}

extension HomeController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
        
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "sliderTVCell", for: indexPath) as! SliderTableViewCell
            cell2.cellDelegate = self
            return cell2
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "showsTVCell", for: indexPath) as! HomeTableViewCell
            cell.collectionView.tag = indexPath.section - 1
            cell.delegate = self

            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 300
        }
        
        return 220
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
}


extension HomeController: CellDelegate {
    func colCategorySelected(_ indexPath : IndexPath){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsController") as! MovieDetailsController
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
}