//
//  LoginController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol login {
    func signInUser(Email: String, Password: String, view: UIViewController)
//    func logoutUser(view: UIViewController)
    func signUpUser(Email: String, Password: String, rePassword: String, view: UIViewController)
}

class LoginController: UIViewController {

    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var logOutview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            logOutview.isHidden = false
            signInView.isHidden = true
            signUpView.isHidden = true
        }
        else{
            signInView.isHidden = false
            signUpView.isHidden = true
            logOutview.isHidden = true
        }
        
        
    }
    
    @IBAction func loginSegmentTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            signInView.isHidden = false
            signUpView.isHidden = true
            logOutview.isHidden = true
        }
        else{
            signInView.isHidden = true
            signUpView.isHidden = false
            logOutview.isHidden = true
        }
    }
    

}
