//
//  Authentication.swift
//  gigis-ios
//
//  Created by Pablo V on 20/05/21.
//

import Foundation

struct LoginRequestBody: Codable {
    let phone_number: String
    let password: String
    let device_name: String
}

struct LoginResponse: Codable {
    let token: String?
}

final class AuthenticationApi {

    /**
     * This method sends a HTTP request to the REST API with the email, the password
     * and the name of the device of the user. If the API is able to validate the credentials
     * of the user, it returns a bearer token that can be used for future requests.
     */
    public static func getToken(phoneNumber: String, password: String, deviceName: String, completionHandler: @escaping (Result<String, NetworkError>) -> Void) {
        guard let endpoint = URL(string: Environment.apiUrl.appending("authenticate")) else {
            completionHandler(.failure(.invalidURL))
            return
        }

        let body = LoginRequestBody(phone_number: phoneNumber, password: password, device_name: deviceName)

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(.failure(.noData))
                return
            }

            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completionHandler(.failure(.decodingError))
                return
            }

            guard let token = loginResponse.token else {
                completionHandler(.failure(.noToken))
                return
            }

            completionHandler(.success(token))
        }.resume()
    }

    /**
     * This method has the purpose of sending the bearer token that the user has
     * to the API. If the request is succesful, the API deletes the token from its database.
     */
    public static func revokeToken(completionHandler: @escaping (Result<String, NetworkError>) -> Void) {
        guard let endpoint = URL(string: Environment.apiUrl.appending("revoke")) else {
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
            if error == nil, let _ = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completionHandler(.success("Token was deleted."))
                } else {
                    completionHandler(.failure(.noToken))
                }
            } else {
                completionHandler(.failure(.noToken))
            }
        }.resume()
    }
}
