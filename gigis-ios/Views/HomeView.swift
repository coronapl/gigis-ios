//
//  HomeView.swift
//  gigis-ios
//
//  Created by Pablo V on 02/05/21.
//

import SwiftUI
import UIKit

struct HomeView: View {

    @EnvironmentObject var authService: AuthService

    private func logout() {
        let defaults = UserDefaults.standard
        let token: String! = defaults.string(forKey: "token")
        print("logout")

        WebServices().logout(token: token) { result in
            switch result {
                case .success(let message):
                    print(message)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

        defaults.removeObject(forKey: "token")
        authService.isAuthenticated = false
    }

    var body: some View {
        Button(action: { self.logout() }, label: {
            LogoutButtonView()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LogoutButtonView: View {
    var body: some View {
        Text("Cerrar sesión")
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(.white)
            .background(orange)
            .cornerRadius(35)
            .padding(.bottom, 20)
    }
}
