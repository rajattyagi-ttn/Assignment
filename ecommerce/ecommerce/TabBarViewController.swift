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
    
    // To reload favourite controller tableview as soon as user update it's favourite show
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        
        switch selectedIndex {
        case 0:
            let nc = viewController as! UINavigationController
            let vc = nc.viewControllers.first as! HomeController
            vc.tableView?.reloadData()
            
        case 1:
            print("Employee Tableview")
            
        
        case 2:
            let nc = viewController as! UINavigationController
            let vc = nc.viewControllers.first as! FavouriteController
            vc.viewDidLoad()
            DispatchQueue.main.async {
                
                vc.favouriteTableView?.reloadData()
            }
            
        case 3:
            print("Chat Controller")
            
        case 4:
            let nc = viewController as! UINavigationController
            let vc = nc.viewControllers.first as! AccountController
            vc.tableView?.reloadData()
            
        default:
            print("default")
            
        }
        
                
    }
}
