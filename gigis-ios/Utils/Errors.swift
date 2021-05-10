//
//  Errors.swift
//  gigis-ios
//
//  Created by Pablo V on 04/05/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case encodingError
    case invalidCredentials
}
