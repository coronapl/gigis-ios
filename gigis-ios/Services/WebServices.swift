//
//  WebServices.swift
//  gigis-ios
//
//  Created by Pablo V on 02/05/21.
//

import Foundation

struct LoginRequestBody: Codable {
    let email: String
    let password: String
    let device_name: String
}

struct LoginResponse: Decodable {
    let token: String?
}

class WebServices {
    
    func login(email: String, password: String, deviceName: String, completed: @escaping (Result<String, NetworkError>) -> Void) {

        guard let endpoint = URL(string: Environment.apiUrl.appending("authenticate")) else {
            completed(.failure(.invalidURL))
            return
        }

        let body = LoginRequestBody(email: email, password: password, device_name: deviceName)

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completed(.failure(.noData))
                return
            }

            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completed(.failure(.invalidCredentials))
                return
            }

            guard let token = loginResponse.token else {
                completed(.failure(.invalidCredentials))
                return
            }

            completed(.success(token))
        }.resume()
    }
    
    func logout(completed: @escaping (Result<String, NetworkError>) -> Void) {

        guard let endpoint = URL(string: Environment.apiUrl.appending("revoke")) else {
            completed(.failure(.invalidURL))
            return
        }

        let defaults = UserDefaults.standard
        let token: String = defaults.string(forKey: "token")!

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let _ = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completed(.success("Token was deleted."))
                } else {
                    completed(.failure(.invalidCredentials))
                }
            } else {
                completed(.failure(.invalidCredentials))
            }
        }.resume()
    }
}
