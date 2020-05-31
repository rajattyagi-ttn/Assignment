//
//  SignUpController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordConfirmTextfield: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    var signup = manualLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpTapped(_ sender: UIButton) {
        signup.signUpUser(Email: emailTextField.text ?? "", name: userNameTextField.text ?? "", Password: passwordTextfield.text ?? "", rePassword: passwordConfirmTextfield.text ?? "", view: self)
    }
    
    
}
