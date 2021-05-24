//
//  Loan.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import Foundation

struct Loan: Codable {
    let id: Int
    let quantity: Int
    let loanedAt: Date
    let returnedAt: Date
    let itemId: Int
    let userId: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case quantity
        case loanedAt = "loaned_at"
        case returnedAt = "returned_at"
        case itemId = "item_id"
        case userId = "user_id"
        case user
    }
}
