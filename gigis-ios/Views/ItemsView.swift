//
//  ItemsView.swift
//  gigis-ios
//
//  Created by Pablo V on 04/05/21.
//

import SwiftUI

struct ItemsView: View {

    @State var items: [Item]
    var color: Color
    var category: String

    var body: some View {
        List(self.items, id: \.id) { item in
            ItemView(item: item)
                .background(Colors.blue)
        }
        .navigationTitle(category)
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(items: [
            Item(
                id: 1,
                name: "Café",
                quantity: 10,
                measurementUnit: "Bolsas",
                canBeLoaned: 0,
                category: Category(id: 1, name: "Cocina", icon: "Kitchen"))
        ],
        color: Colors.blue,
        category: "Cocina")
    }
}
