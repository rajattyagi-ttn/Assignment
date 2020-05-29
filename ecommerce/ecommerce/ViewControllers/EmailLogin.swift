//
//  EmailLogin.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 29/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class manualLogin : login
{
    //MARK: User Login Function
    
    func signInUser(Email: String, Password: String, view: UIViewController) {
    
    
        Auth.auth().signIn(withEmail: Email, password: Password) { (user, error) in
            
            //If no error occurs then complete the login process
            if error == nil{
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "AccountController")
                view.navigationController?.pushViewController(vc, animated: true)
            }
                
            //If the user is already logged in with an account then they need to logout to use another one
            else if Auth.auth().currentUser != nil {
                
                let alertController = UIAlertController(title: "Already Logged in", message: "Kindly Log-out to use a different login account", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
            }
                
            //Check for login error like incorrect format if email id and password size
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: User Logout Function
    func logoutUser(view: UIViewController) {

        //No user exist but trying to sign out
        if Auth.auth().currentUser == nil {

            let alertController = UIAlertController(title: "Sign In first", message: "No user exist kindly sign in first", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
        do {
            //Try signing out
            try Auth.auth().signOut()
            //            let alertController = UIAlertController(title: "Logged Out", message: "Successfully Logged Out", preferredStyle: .alert)
            //            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            //            alertController.addAction(defaultAction)
            //            self.present(alertController, animated: true, completion: nil)
        }
        catch let signOutError as NSError {
            //Catch error if any while signin out
            print ("Error signing out: %@", signOutError)
        }


    }
    
    //MARK: User Signup Function
    func signUpUser(Email: String, Password: String, rePassword: String, view: UIViewController) {
        
        //Check for password and re-typed password

        if Password != rePassword {
            let alertController = UIAlertController(title: "Password Do not match", message: "Please re-type the password correctly", preferredStyle: .alert)
            print(Password)
            print(rePassword)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
        //If the user is already logged in with an account then they need to logout to use another one

        else if Auth.auth().currentUser != nil {
            
            let alertController = UIAlertController(title: "Already Signed in", message: "Kindly Log-out to use a different login account", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
        //If no error occurs then complete the Sign up process

        else{
            Auth.auth().createUser(withEmail: Email, password: Password){ (user, error) in
                if error == nil {
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "AccountController")
                    view.navigationController!.pushViewController(vc, animated: true)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    view.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

