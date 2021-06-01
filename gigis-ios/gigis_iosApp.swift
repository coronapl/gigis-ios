//
//  gigis_iosApp.swift
//  gigis-ios
//
//  Created by Pablo V on 01/05/21.
//

import SwiftUI
import PartialSheet

@main
struct gigis_iosApp: App {
    @StateObject private var authService = AuthService()

    let sheetManager: PartialSheetManager = PartialSheetManager()

    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                    MenuView()
                        .environmentObject(authService)
                        .environmentObject(sheetManager)
            } else {
                LoginView(authService: authService)
            }
        }
    }
}
