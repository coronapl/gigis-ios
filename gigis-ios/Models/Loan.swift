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
    let loanedAt: String
    let returnedAt: String?
    let itemId: Int
    let userId: Int
    let user: User
    let item: Item

    enum CodingKeys: String, CodingKey {
        case id
        case quantity
        case loanedAt = "loaned_at"
        case returnedAt = "returned_at"
        case itemId = "item_id"
        case userId = "user_id"
        case user
        case item
    }
}

final class LoanApi {
    public static func all(completionHandler: @escaping (Result<[Loan], NetworkError>) -> Void) {
        guard let endpoint = URL(string: Environment.apiUrl.appending("loans/personal")) else {
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

            guard let loansResponse = try? JSONDecoder().decode([Loan].self, from: data) else {
                completionHandler(.failure(.decodingError))
                return
            }

            completionHandler(.success(loansResponse))
        }.resume()
    }

    public static func returnLoan(loanId: Int, completionHandler: @escaping (Result<ApiResponse, NetworkError>) -> Void) {
        guard let endpoint = URL(string: Environment.apiUrl.appending("loans/\(loanId)/return")) else {
            completionHandler(.failure(.invalidURL))
            return
        }

        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completionHandler(.failure(.noToken))
            return
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

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
