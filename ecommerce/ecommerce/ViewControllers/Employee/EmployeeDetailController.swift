//
//  EmployeeDetailController.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 26/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit
import Alamofire

class EmployeeDetailController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    
    var employeeImages = [#imageLiteral(resourceName: "employee1"),#imageLiteral(resourceName: "employee4"),#imageLiteral(resourceName: "employee3"),#imageLiteral(resourceName: "employee2")]
    
    var employeeArray = [EmployeeResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        getEmployeeData()
        
        let nib = UINib(nibName: "EmployeeDetailTableViewCell", bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: "employeeDetailTVCell")
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupTheme()
        
    }
    
    func setupTheme() {
        view.backgroundColor = Theme.color(type: .backgroundColor)
        detailTableView.backgroundColor = Theme.color(type: .backgroundColor)
    }
    
    func getEmployeeData() {
        let request = AF.request("http://dummy.restapiexample.com/api/v1/employees")
        
        request.responseDecodable(of: EmployeeBaseModel.self) { (response) in
          
            guard let employeeData = response.value else { return }
            self.employeeArray = employeeData.data
            
            self.detailTableView.reloadData()
        }

    }
}

extension EmployeeDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "employeeDetailTVCell", for: indexPath) as! EmployeeDetailTableViewCell
        
        cell.employeeImageView.image = employeeImages[indexPath.row % 4]
        
        cell.employeeNameLabel.text = "\(employeeArray[indexPath.row].employeeName)  •  \(employeeArray[indexPath.row].employeeAge)"
        
        cell.employeeDetailsLabel.text = "ID : \(employeeArray[indexPath.row].id)  Salary : ₹ \(employeeArray[indexPath.row].employeeSalary) "
        
        cell.backgroundColor = Theme.color(type: .backgroundColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
