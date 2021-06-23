//
//  ApiResponse.swift
//  gigis-ios
//
//  Created by Pablo V on 01/06/21.
//

import Foundation

struct ApiResponse: Codable {
    var id: Int?
    var success: Bool
    var message: String
}
