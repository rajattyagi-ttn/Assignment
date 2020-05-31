//
//  PasswordResetController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 30/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordResetController: UIViewController {

    @IBOutlet weak var resetChoiceLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var securityQuestionLabel: UILabel!
    @IBOutlet weak var securityAnswerTextField: UITextField!
    @IBOutlet weak var bySecurityQuestionButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var byEmailButton: UIButton!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    
    var byEmail: Bool?
    var didEnter = false
    
    
    let fireBaseLoginObj = FireBaseLogin()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetChoiceLabel.isHidden = false
        byEmailButton.isHidden = false
        bySecurityQuestionButton.isHidden = false
        emailTextField.isHidden = false
        securityQuestionLabel.isHidden = true
        securityAnswerTextField.isHidden = true
        submitButton.isHidden = true
        newPasswordTextfield.isHidden = true
        
        emailTextField.delegate = self
        securityAnswerTextField.delegate = self
        newPasswordTextfield.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupTheme()
        
    }
    
    func setupTheme() {
        view.backgroundColor = Theme.color(type: .backgroundColor)
    }
    
    @IBAction func byEmailTapped(_ sender: UIButton) {
        
        resetChoiceLabel.isHidden = false
        byEmailButton.isHidden = true
        bySecurityQuestionButton.isHidden = true
        emailTextField.isHidden = false
        securityQuestionLabel.isHidden = true
        securityAnswerTextField.isHidden = true
        submitButton.isHidden = false
        newPasswordTextfield.isHidden = true
        byEmail = true
    }
    
    @IBAction func BySecurityQuestionTapped(_ sender: UIButton) {
        
        if emailTextField.text?.isEmpty == true {
            let alertController = UIAlertController(title: "Error", message: "Please Enter Email First", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            resetChoiceLabel.isHidden = false
            
            
            
            
            self.byEmail = false
            
            let email = emailTextField.text
            let oldPass = UserDefaults.standard.string(forKey: "\(email)userPassword") ?? ""
            
            Auth.auth().signIn(withEmail: email!, password: oldPass) { (user, error) in
            
            //If no error occurs then complete the login process
                if error == nil{
                    
                    print("Successfuly login in password reset")
                    self.securityAnswerTextField.isHidden = false
                    self.byEmailButton.isHidden = true
                    self.bySecurityQuestionButton.isHidden = true
                    self.emailTextField.isHidden = false
                    self.securityQuestionLabel.isHidden = false
                    self.submitButton.isHidden = false
                    

                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    self.securityAnswerTextField.isHidden = true
                    self.newPasswordTextfield.isHidden = true
                    self.byEmailButton.isHidden = false
                    self.bySecurityQuestionButton.isHidden = false
                    self.emailTextField.isHidden = false
                    self.securityQuestionLabel.isHidden = true
                    self.submitButton.isHidden = true
                    print("Some Error Occured in Password reset login", error)
                }
            }
        }
        
        
        
        
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        if didEnter {
            print("in did enter")
            let email = emailTextField.text
            let newPass = newPasswordTextfield.text
            let oldPass = UserDefaults.standard.string(forKey: "\(email)userPassword") ?? ""
            UserDefaults.standard.set(newPass, forKey: "\(email)userPassword")
            
            let credential = EmailAuthProvider.credential(withEmail: email!, password: oldPass)
            
            
            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (authResult, error) in
                if error == nil {
                    Auth.auth().currentUser?.updatePassword(to: newPass ?? "") { (error) in
                        if error != nil {
                            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                            print("Some error occured while changing pass in firebase", error)
                        }
                        else{
                            let alertController = UIAlertController(title: "Success", message: "Succesfully changed Password", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            alertController.addAction(defaultAction)
                            self.navigationController?.popViewController(animated: true)
                            do {
                                //Try signing out
                                try Auth.auth().signOut()
                                
                            }
                            catch let signOutError as NSError {
                                //Catch error if any while signin out
                                print ("Error signing out: %@", signOutError)
                            }
                            print("Succesfully changed Password")
                        }
                    }
                }
                else{
                    print("Some Error occured during reauthenticating", error)
                }
            })
           
            print("After update password")
        }
        else{
            guard let email = emailTextField.text else { return }
            if byEmail!{
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                    if error == nil {
                        let alertController = UIAlertController(title: "Success", message: "Password reset mail has been sent to you. Please check you mail", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    else {
                        print("Error Occured while sending reset mail",error)
                    }
                    
                }
            }
            else {
                let email = emailTextField.text
                let retrievedSecurityAnswer = UserDefaults.standard.string(forKey: "\(email)userSecurityAnswer")
                let securityAnswer = securityAnswerTextField.text
                
                if securityAnswer != retrievedSecurityAnswer {
                    let alertController = UIAlertController(title: "Security Answer Doesn't Match", message: "Enter Correct Security Answer", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    didEnter = true
                    print("Did enter Value : ",didEnter)
                    submitButton.setTitle("Submit", for: .normal)
                    newPasswordTextfield.isHidden = false
                }
                
                
            }
            
        }
        
    }
    
}

extension PasswordResetController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
