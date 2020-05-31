//
//  EmployeeListController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 26/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire

class EmployeeListController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    var employeeArray = [EmployeeResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        getEmployeeData()
        
        let nib = UINib(nibName: "EmployeeListTableViewCell", bundle: nil)
        listTableView.register(nib, forCellReuseIdentifier: "employeeListTVCell")
       
    }
    
    func getEmployeeData() {
        let request = AF.request("http://dummy.restapiexample.com/api/v1/employees")

        request.responseDecodable(of: EmployeeBaseModel.self) { (response) in
          
            guard let employeeData = response.value else { return }
            self.employeeArray = employeeData.data
            
            self.listTableView.reloadData()
        }
    }
    
}


extension EmployeeListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = listTableView.dequeueReusableCell(withIdentifier: "employeeListTVCell", for: indexPath) as! EmployeeListTableViewCell
               
        print(employeeArray[indexPath.row].id)
        cell.employeeIDLabel.text = "ID : \(employeeArray[indexPath.row].id)"
//        print(cell.employeeIdLabel.text)
        cell.employeeNameLabel.text = "Name : \(employeeArray[indexPath.row].employeeName)"
        print(cell.employeeNameLabel.text)
               
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}