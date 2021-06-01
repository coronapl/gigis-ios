//
//  ItemsView.swift
//  gigis-ios
//
//  Created by Pablo V on 04/05/21.
//

import SwiftUI
import PartialSheet

struct ItemsView: View {

    @EnvironmentObject var itemsController: ItemsController
    @EnvironmentObject var partialSheet : PartialSheetManager
    @State var items: [Item]
    @State private var quantity = 1

    var color: Color
    var category: String

    var body: some View {
        List(self.items, id: \.id) { item in
            Button(action: {
                self.partialSheet.showPartialSheet {
                    print("dismissed")
                } content: {
                    VStack {
                        Text("Selecciona la cantidad a sacar de \(item.name)")
                            .font(.headline)
                            .padding(.bottom)
                        Picker("", selection: self.$quantity) {
                            ForEach(1...item.quantity, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Button(action: {
                            self.itemsController.takeItem(id: item.id, quantity: self.quantity)
                            self.partialSheet.closePartialSheet()
                            self.quantity = 0
                        }, label: {
                            Text("Sacar")
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(.white)
                                .background(Colors.green)
                                .cornerRadius(35)
                        })
                            .padding(.top)
                    }
                }
            }, label: {
                ItemView(item: item)
                    .background(Colors.blue)
            })
        }
        .navigationTitle(category)
        .addPartialSheet()
        .onAppear {
            self.itemsController.getItems()
        }
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
