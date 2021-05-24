//
//  User.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let employeeId: Int?
    let phoneNumber: String
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case employeeId = "employee_id"
        case phoneNumber = "phone_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
