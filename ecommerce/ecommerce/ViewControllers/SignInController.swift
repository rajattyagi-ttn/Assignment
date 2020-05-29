//
//  SignInController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class SignInController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var signIn = manualLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
        signIn.signInUser(Email: userNameTextField.text ?? "", Password: passwordTextfield.text ?? "", view: self)
    }
    
   

}
