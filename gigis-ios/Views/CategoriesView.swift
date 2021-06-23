//
//  CategoriesView.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import SwiftUI

struct CategoriesView: View {

    @StateObject var itemsController: ItemsController = ItemsController()
    @EnvironmentObject var authService: AuthService

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Categorías")) {
                    ForEach(self.itemsController.items.keys.sorted(), id: \.self) { category in
                        NavigationLink(
                            destination: ItemsView(
                                color: Colors.blue,
                                category: category
                            ).environmentObject(itemsController),
                            label: {
                                Text(category)
                            })
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: Button(action: {
                self.authService.logout()
            }, label: {
                Text("Salir")
            }))
            .navigationTitle("Inventario")
        }.onAppear {
            self.itemsController.getItems()
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
