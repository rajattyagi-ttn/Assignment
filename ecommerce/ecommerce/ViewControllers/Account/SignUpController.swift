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
    @IBOutlet weak var securityAnswerTextField: UITextField!
    
    var signup = FireBaseLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextfield.delegate = self
        passwordConfirmTextfield.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupTheme()
        
    }
    
    func setupTheme() {
        view.backgroundColor = Theme.color(type: .backgroundColor)
    }
    

    @IBAction func signUpTapped(_ sender: UIButton) {
        signup.signUpUser(Email: emailTextField.text ?? "", name: userNameTextField.text ?? "", Password: passwordTextfield.text ?? "", rePassword: passwordConfirmTextfield.text ?? "", view: self)
        
        let email = emailTextField.text
        let password = passwordConfirmTextfield.text
        let securityAnswer = securityAnswerTextField.text
        
        UserDefaults.standard.set(email, forKey: "\(email)userEmail")
        UserDefaults.standard.set(password, forKey: "\(email)userPassword")
        UserDefaults.standard.set(securityAnswer, forKey: "\(email)userSecurityAnswer")
        
    }
    
    
}

extension SignUpController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
