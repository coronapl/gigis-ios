//
//  AuthService.swift
//  gigis-ios
//
//  Created by Pablo V on 04/05/21.
//

import Foundation

final class AuthService: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    init() {
        // Verify if user is authenticated
        self.verifyAuthentication()
    }

    /**
     * This method has the purpose if verifying if the user has a token stored in User Defaults. If it is the case,
     * the user is considered as authenticated. The token can be used to make HTTP requests to the GiGi's
     * inventory REST API.
     */
    private func verifyAuthentication() -> Void {
        guard UserDefaults.standard.string(forKey: "token") != nil else {
            self.isAuthenticated = false
            return
        }
        self.isAuthenticated = true
    }


    /**
     * This method calls the revokeToken method so that the bearer token is deleted from the API database.
     * Even if the request fails, the token is deleted from User Defaults. The user is no longer authenticated.
     */
    public func logout() -> Void {
        AuthenticationApi.revokeToken() { result in
            switch result {
                case .success(let message):
                    print(message)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

        // Remove token from user defaults
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
        self.isAuthenticated = false
    }
}
