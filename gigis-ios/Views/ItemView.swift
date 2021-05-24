//
//  ItemView.swift
//  gigis-ios
//
//  Created by Pablo V on 10/05/21.
//

import SwiftUI

struct ItemView: View {
    @State var item: Item
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(item.quantity) \(item.measurementUnit)", systemImage: "number")
                    .accessibilityElement(children: .ignore)
                Spacer()
                Label("\(item.category)", systemImage: "folder")
                    .padding(.trailing, 20)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item(
            id: 1,
            name: "Rompecabezas",
            quantity: 100,
            measurementUnit: "piezas",
            canBeLoaned: 1,
            categoryId: 1,
            category: "Didáctico",
            icon: "no hay"
        ))
            .background(Colors.blue)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
