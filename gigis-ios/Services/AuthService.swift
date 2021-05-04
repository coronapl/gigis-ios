//
//  AuthService.swift
//  gigis-ios
//
//  Created by Pablo V on 04/05/21.
//

import Foundation

final class AuthService: ObservableObject {
    @Published var isAuthenticated: Bool
    
    init() {
        // Verify if user is authenticated
        let defaults = UserDefaults.standard
        self.isAuthenticated = defaults.string(forKey: "token") != nil ? true : false;
    }
}
