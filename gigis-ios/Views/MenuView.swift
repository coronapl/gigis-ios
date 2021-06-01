//
//  MenuView.swift
//  gigis-ios
//
//  Created by Pablo V on 21/05/21.
//

import SwiftUI

struct MenuView: View {

    @EnvironmentObject var authService: AuthService
    @StateObject var loansController: LoansContoller = LoansContoller()

    var body: some View {
        TabView {
            CategoriesView()
                .tabItem {
                    Label("Sacar", systemImage: "square.and.arrow.up")
                }
            LoansView()
                .tabItem {
                    Label("Regresar", systemImage: "square.and.arrow.down")
                }
                .environmentObject(loansController)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView()
        }
    }
}
