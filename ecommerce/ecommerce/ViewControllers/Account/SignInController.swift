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
import FBSDKLoginKit


class SignInController: UIViewController{
    

    @IBOutlet weak var signInMessageLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var manualSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var fbSignInButton: FBLoginButton!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    
    
    var signIn = FireBaseLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passwordTextfield.delegate = self
        
        let forgetPasswordLabelTap = UITapGestureRecognizer(target: self, action: #selector(forgetPasswordAction))
        
        forgetPasswordLabel.isUserInteractionEnabled = true
        forgetPasswordLabel.addGestureRecognizer(forgetPasswordLabelTap)
        
        self.hideKeyboardWhenTappedAround()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        fbSignInButton.delegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        // To remove fblogin button default height connstraint
        let layoutConstraintsArr = fbSignInButton.constraints
        
        for lc in layoutConstraintsArr {
           if ( lc.constant == 28 ){
           
            lc.isActive = false
             break
           }
        }
        
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
             manualSignInButton.backgroundColor = Theme.color(type: .brandColor)
         }
         
         if UserDefaults.standard.object(forKey: "fontColor") != nil {
            manualSignInButton.setTitleColor(Theme.Fonts.fontColor(), for: .normal)
            signInMessageLabel.textColor = Theme.Fonts.fontColor()
            forgetPasswordLabel.textColor = Theme.Fonts.fontColor()
         }
         
         if UserDefaults.standard.object(forKey: "font") != nil {
            manualSignInButton.titleLabel?.font = Theme.Fonts.font()
            signInMessageLabel.font = Theme.Fonts.font()
            forgetPasswordLabel.font = Theme.Fonts.font()
        }
        
    }
    
    //MARK:- FB FIREBASE AUTHENTICATION/Users/rajat/Desktop/Assignment/ecommerce/ecommerce/ecommerceTests
    
    func fbFireBaseAuthenticate() {
        
        let accessToken = AccessToken.current
        
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        Auth.auth().signIn(with: credentials) { (authResult, err) in
            if err != nil {
                print("Something went wrong with firebase fb authentication", err)
                return
            }

            print("Success Logged into Firebase using FB")
            self.navigationController?.popViewController(animated: true)
            
        }
        
        let graphRequest = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"],tokenString: accessTokenString,version: nil,httpMethod: .get)
        
        graphRequest.start { (connection, result, error) -> Void in
            if error == nil {
                print("result \(String(describing: result))")
            }
            else {
                print("error \(String(describing: error))")
            }
        }
        
        
    }
    
    //MARK:- Poping After Successful Signin into google
    func googleDidSignIn() {
        
        
        self.navigationController?.popViewController(animated: true)

    }
    
    
    @objc func forgetPasswordAction() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PasswordResetController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
        signIn.signInUser(Email: userNameTextField.text ?? "", Password: passwordTextfield.text ?? "", view: self)
    }
    
    

}


extension SignInController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
        }
        fbFireBaseAuthenticate()
        print("Succesfuly Login to FB")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout of facebook")
        
    }

}


extension SignInController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let err = error {
            print("Failed to log into Google", err)
            return
        }
        print("Succesfully Logged into Google", user)
      
        guard let authentication = user.authentication else { return }
        
        guard let idToken = authentication.idToken else { return }
        guard let accessToken = authentication.accessToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                        accessToken: accessToken)
      
        Auth.auth().signIn(with: credential) { (user, error) in
            if let err = error {
                print("Failed to create a Firebase user with Google account", err)
                return
            }
            
            guard let uid = user?.user.uid else {return}
            print("Succesfully Logged into Firebase with Google", uid)
            self.googleDidSignIn()
 
        }
    }
 
}

extension SignInController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
