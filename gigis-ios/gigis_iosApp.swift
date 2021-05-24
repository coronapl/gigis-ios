//
//  gigis_iosApp.swift
//  gigis-ios
//
//  Created by Pablo V on 01/05/21.
//

import SwiftUI

@main
struct gigis_iosApp: App {
    @StateObject private var authService = AuthService()

    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                    MenuView()
                        .environmentObject(authService)
            } else {
                LoginView(authService: authService)
            }
        }
    }
}
