//
//  LoginViewController.swift
//  gigis-ios
//
//  Created by Pablo V on 20/05/21.
//

import Foundation
import UIKit

class LoginController: ObservableObject {

    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""

    private var authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    public func login() {
        if self.phoneNumber.isEmpty || password.isEmpty {
            self.errorMessage = "Campos incompletos."
            return
        }

        if !self.phoneNumber.isEmpty && self.phoneNumber.count != 10 {
            self.errorMessage = "El número tiene que ser de 10 dígitos."
            return
        }

        AuthenticationApi.getToken(phoneNumber: phoneNumber, password: password, deviceName: UIDevice.current.name) { result in
            switch result {
                case .success(let token):
                    // Save token to user defaults
                    UserDefaults.standard.setValue(token, forKey: "token")

                    // Authenticate user
                    DispatchQueue.main.async {
                        self.authService.isAuthenticated = true
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Hubo un error. Intentar de nuevo."
                    }
                    print(error.localizedDescription)
            }
        }
    }
}
