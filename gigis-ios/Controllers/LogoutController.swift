//
//  LogoutController.swift
//  gigis-ios
//
//  Created by Pablo V on 20/05/21.
//

import Foundation

class LogoutController: ObservableObject {

    var authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

}
