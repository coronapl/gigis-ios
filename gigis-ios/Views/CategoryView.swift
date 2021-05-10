//
//  CategoryView.swift
//  gigis-ios
//
//  Created by Pablo V on 10/05/21.
//

import SwiftUI

struct CategoryView: View {

    var items: [Item]
    var color: Color
    var title: String
    var icon: String
    
    @EnvironmentObject var authService: AuthService

    private func logout() {
        WebServices().logout() { result in
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
        authService.isAuthenticated = false
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.id) { item in
                    ItemView(item: item)
                        .listRowBackground(color)
                }
            }
            .navigationTitle(title)
            .navigationBarItems(trailing: Button(action: { logout() }) {
                Image(systemName: "arrow.right.circle")
            })
        }
        .tabItem {
            Label(title, systemImage: icon)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(
            items: [Item(id: 1, name: "Rompecabezas", quantity: 100, measurementUnit: "piezas", canBeLoaned: 1, categoryId: 1, category: "Didáctico", icon: "no hay")],
            color: Colors.blue,
            title: "Juegos",
            icon: "gameController"
        )
    }
}
