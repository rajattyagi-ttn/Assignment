//
//  EmployeeModel.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 30/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import Foundation

struct EmployeeBaseModel: Decodable {
    var status: String
    var data: [EmployeeResultModel]
}


struct EmployeeResultModel: Codable {
    
    let id: String
    let employeeName: String
    let employeeSalary: String
    let employeeAge: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
    }
    
}
