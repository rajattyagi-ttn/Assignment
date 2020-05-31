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
    func signUpUser(Email: String, name: String, Password: String, rePassword: String, view: UIViewController)
}

class LoginController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if Auth.auth().currentUser != nil {
            signInView.isHidden = true
            signUpView.isHidden = true
        }
        else{
            signInView.isHidden = false
            signUpView.isHidden = true
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("INSIDE LOGIN VIEW WILL APPEAR")
        setupTheme()
        
    }
    
    func setupTheme() {
        
        if UserDefaults.standard.object(forKey: "backgroundColour") != nil {
            view.backgroundColor = Theme.color(type: .backgroundColor)
            contentView.backgroundColor = Theme.color(type: .backgroundColor)
        }
        
        
        
        
    }
    
    @IBAction func loginSegmentTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            signInView.isHidden = false
            signUpView.isHidden = true
          
        }
        else{
            signInView.isHidden = true
            signUpView.isHidden = false
           
        }
    }
    

}
