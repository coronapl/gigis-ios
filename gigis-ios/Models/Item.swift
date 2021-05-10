//
//  Item.swift
//  gigis-ios
//
//  Created by Pablo V on 04/05/21.
//

import Foundation

struct Item: Codable {
    let id: Int
    let name: String
    let quantity: Int
    let measurementUnit: String
    let canBeLoaned: Int
    let categoryId: Int
    let category: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
        case measurementUnit = "measurement_unit"
        case canBeLoaned = "can_be_loaned"
        case categoryId = "category_id"
        case category
        case icon
    }
}
