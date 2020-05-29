//
//  TabBarViewController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex == 2 {
            let nc = viewController as! UINavigationController
            let vc = nc.viewControllers.first as! FavouriteController
            DispatchQueue.main.async {
                vc.viewDidLoad()
                vc.favouriteTableView.reloadData()
            }
            
        }
    }
}
