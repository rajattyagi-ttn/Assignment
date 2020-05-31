//
//  SignInController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn


class SignInController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    var signIn = manualLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
    }
    
    @objc func didSignIn() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AccountController")
        print("Pushing")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
        signIn.signInUser(Email: userNameTextField.text ?? "", Password: passwordTextfield.text ?? "", view: self)
    }
    
    @IBAction func googleSignInButtonTapped(_ sender: GIDSignInButton) {
    }
    
    deinit {
        print("IN Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    

}
