//
//  LoginViewModel.swift
//  gigis-ios
//
//  Created by Pablo V on 02/05/21.
//

import Foundation
import UIKit

class LoginViewModel: ObservableObject {

    var email: String = ""
    var password: String = ""

    @Published var errorMessage: String = ""
    @Published var isAuthenticated: Bool = false

    func login() {
        if email.isEmpty || password.isEmpty {
            self.errorMessage = "Campos incompletos."
            return
        }

        let defaults = UserDefaults.standard

        WebServices().login(email: email.lowercased(), password: password, deviceName: UIDevice.current.name) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "token")
                    defaults.setValue(true, forKey: "isAuthenticated")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
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
