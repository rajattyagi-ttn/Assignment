//
//  LogOutController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class LogOutController: UIViewController {

    var logout = manualLogin()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutTapped(_ sender: UIButton) {
        logout.logoutUser(view: self)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginController")
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
