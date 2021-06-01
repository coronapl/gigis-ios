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
    let category: Category?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
        case measurementUnit = "measurement_unit"
        case canBeLoaned = "can_be_loaned"
        case category
    }
}

struct TakeItemBody: Codable {
    var quantity: Int
}

final class ItemApi {

    public static func all(completionHandler: @escaping (Result<[Item], NetworkError>) -> Void) {
        guard let endpoint = URL(string: Environment.apiUrl.appending("items")) else {
            completionHandler(.failure(.invalidURL))
            return
        }

        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completionHandler(.failure(.noToken))
            return
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(.noData))
                return
            }

            guard let itemsResponse = try? JSONDecoder().decode([Item].self, from: data) else {
                completionHandler(.failure(.decodingError))
                return
            }

            completionHandler(.success(itemsResponse))
        }.resume()
    }

    public static func takeItem(id: Int, quantity: Int, completionHandler: @escaping (Result<ApiResponse, NetworkError>) -> Void) {
        guard let endpoint = URL(string: Environment.apiUrl.appending("items/\(id)/output")) else {
            completionHandler(.failure(.invalidURL))
            return
        }

        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completionHandler(.failure(.noToken))
            return
        }

        let body = TakeItemBody(quantity: quantity)

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(.noData))
                return
            }

            guard let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                completionHandler(.failure(.decodingError))
                return
            }

            completionHandler(.success(apiResponse))
        }.resume()
    }
}
