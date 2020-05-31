//
//  SignUpController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var signUpMessageLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordConfirmTextfield: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var securityAnswerTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var securityQuestionLabel: UILabel!
    
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
        if UserDefaults.standard.object(forKey: "backgroundColour") == nil {
            view.backgroundColor = UIColor.black
        }
        else{
            view.backgroundColor = Theme.color(type: .backgroundColor)
        }
        
        if UserDefaults.standard.object(forKey: "brandColour") != nil {
            signUpButton.backgroundColor = Theme.color(type: .brandColor)
         }
         
         if UserDefaults.standard.object(forKey: "fontColor") != nil {
            signUpButton.setTitleColor(Theme.Fonts.fontColor(), for: .normal)
            signUpMessageLabel.textColor = Theme.Fonts.fontColor()
            securityQuestionLabel.textColor = Theme.Fonts.fontColor()
         }
         
         if UserDefaults.standard.object(forKey: "font") != nil {
            signUpButton.titleLabel?.font = Theme.Fonts.font()
            signUpMessageLabel.font = Theme.Fonts.font()
            securityQuestionLabel.font = Theme.Fonts.font()
        }
        
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
