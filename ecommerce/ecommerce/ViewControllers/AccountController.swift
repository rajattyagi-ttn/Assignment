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
    
    public static var recievedCountryCode : String?
    public static var recievedFlagImage : UIImage?
    public static var recievedLanguage : String?
    let imagePicker = UIImagePickerController()
    let headerTitles = [" "," "]
    let countryIndex = 0
    let languageIndex = 1
    let defaultCountryCode = "in"
    let defaultCountryFlagImage = #imageLiteral(resourceName: "globe")
    let defaultLanguageName = "HINDI"
    
    public static var choice = CellMode.none
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "AccountCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "accountcell")
        
        let nib2 = UINib.init(nibName: "CountryCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "countrycell")
        
        let nib3 = UINib.init(nibName: "LanguageCell", bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: "languagecell")
        
        imagePicker.delegate = self
        
        configureImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        if let selectedCountry = AccountController.recievedCountryCode {
             let countryIndexPath = IndexPath(row: countryIndex, section: 1)
            let countryCell = tableView.cellForRow(at: countryIndexPath) as! CountryCell
            countryCell.countryNameLabel.text = selectedCountry
            if let url = URL(string: "https://www.countryflags.io/\(selectedCountry)/shiny/64.png") {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            
                            //here i pass image to cell.FlagImage
                            
                            countryCell.setCountryFlagImageView(image: UIImage(data: data) ?? self.defaultCountryFlagImage)
                            countryCell.countryFlagImageView.contentMode = .scaleAspectFill

                        }
                    }
                }.resume()
                
            }
        }
        
        if let selectedLanguage = AccountController.recievedLanguage {
            let languageIndexPath = IndexPath(row: languageIndex, section: 1)
            let languageCell = tableView.cellForRow(at: languageIndexPath) as! LanguageCell
            languageCell.languageNameLabel.text = selectedLanguage.uppercased()
        
        }
        
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInController")
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func joinTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JoinController")
        self.navigationController?.pushViewController(vc, animated: true)

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

extension AccountController : UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountMenu.accountMenuItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 && indexPath.row == countryIndex {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "countrycell", for: indexPath) as! CountryCell
            cell.cellIconImageView.image = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowIcon
            cell.cellTitleLabel.text = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName
            cell.countryNameLabel.text = defaultCountryCode.uppercased()
            
            if let url = URL(string: "https://www.countryflags.io/\(defaultCountryCode)/shiny/64.png") {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            
                            //here i pass image to cell.FlagImage
                            
                            cell.setCountryFlagImageView(image: UIImage(data: data) ?? self.defaultCountryFlagImage)
                            cell.countryFlagImageView.contentMode = .scaleAspectFill

                        }
                    }
                }.resume()
                
            }
            return cell
        }
        
        else if indexPath.section == 1 && indexPath.row == languageIndex {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "languagecell", for: indexPath) as! LanguageCell
            cell.cellIconImageView.image = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowIcon
            cell.cellTitleLabel.text = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName
            cell.languageNameLabel.text = String(defaultLanguageName.prefix(3))
            
            return cell
            
        }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "accountcell", for: indexPath) as! AccountCell
            cell.menuItemImageView.image = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowIcon
            cell.menuItemLabel.text = AccountMenu.accountMenuItems[indexPath.section][indexPath.row].rowName
            cell.additionalLabel.isHidden = true
            
            return cell
        }
        
        

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
            
            AccountController.choice = .country
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ChoiceListController")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        else if indexPath.row == languageIndex && indexPath.section == 1 {
            
            AccountController.choice = .language
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ChoiceListController")
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
