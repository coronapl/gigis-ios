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
}
