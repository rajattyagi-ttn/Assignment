//
//  AccountController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 20/03/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

var cntry : String!

class AccountController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    public static var recievedCountry : String?
    public static var recievedLanguage : String?
    let imagePicker = UIImagePickerController()
    let headerTitles = [" "," "]
    let countryIndex = 0
    let languageIndex = 1
    
    public static var choice = ""
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "AccountCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "accountcell")
        
        imagePicker.delegate = self
        
        configureImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        if let selectedCountry = AccountController.recievedCountry {
             let countryIndexPath = IndexPath(row: countryIndex, section: 1)
            let countryCell = tableView.cellForRow(at: countryIndexPath) as! AccountCell
            countryCell.additionalLabel.text = selectedCountry
        }
        
        if let selectedLanguage = AccountController.recievedLanguage {
            let languageIndexPath = IndexPath(row: languageIndex, section: 1)
            let languageCell = tableView.cellForRow(at: languageIndexPath) as! AccountCell
            languageCell.additionalLabel.text = selectedLanguage.uppercased()
        
        }
        
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInController")
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func joinTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JoinController")
        present(vc, animated: true, completion: nil)
    }
    
    
    func configureImageView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectProfilePicture))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    
    @objc func selectProfilePicture() {

        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {

            profileImageView.image = pickedImage 
        }
               
        dismiss(animated: true, completion: nil)

    }

}

extension AccountController : UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountMenu.accountMenuItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountcell", for: indexPath) as! AccountCell
        cell.menuItemImageView.image = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowIcon
        cell.menuItemLabel.text = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName
        cell.additionalLabel.isHidden = true
        if  indexPath.section == 1 && indexPath.row == countryIndex || indexPath.section == 1 && indexPath.row == languageIndex {
            
            cell.additionalLabel.isHidden = false
            
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AccountMenu.accountMenuItems.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headerTitles[section]
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.row == countryIndex && indexPath.section == 1 {
            
            AccountController.choice = "country"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CountryListController")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        else if indexPath.row == languageIndex && indexPath.section == 1 {
            
            AccountController.choice = "language"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CountryListController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else {
            showToast(controller: self, message: "\(AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName)", seconds: 1.0)
        }
        
    }
    
    // Function to show a Toast (Temporary)
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.white
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
}
