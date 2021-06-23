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
    @State private var quantity = 1
    @State private var showingSheet = false
    @State private var showingAlert = false

    let colors = [Colors.blue, Colors.orange, Colors.green, Colors.yellow, Colors.pink, Colors.aqua]

    var color: Color
    var category: String

    var body: some View {
        List(self.itemsController.items[category]!.indices, id: \.self) { index in
            Button(action: {
                self.showingSheet.toggle()
            }, label: {
                VStack(alignment: .leading) {
                    Text(self.itemsController.items[category]![index].name)
                        .font(.headline)
                    Spacer()
                    HStack {
                        Label("\(self.itemsController.items[category]![index].quantity) \(self.itemsController.items[category]![index].measurementUnit)", systemImage: "number")
                            .accessibilityElement(children: .ignore)
                        Spacer()
                        Label("\(self.itemsController.items[category]![index].category!.name)", systemImage: "folder")
                            .padding(.trailing, 20)
                    }
                    .font(.caption)
                }
                .padding()
                .foregroundColor(.white)
                .background(colors[index % 6])
            })
            .sheet(isPresented: self.$showingSheet) {
                VStack {
                    Text("Selecciona la cantidad a sacar de \(self.itemsController.items[category]![index].name)")
                        .font(.headline)
                        .padding(.bottom)
                    Picker("", selection: self.$quantity) {
                        ForEach(1...self.itemsController.items[category]![index].quantity, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    Button(action: {
                        self.itemsController.takeItem(id: self.itemsController.items[category]![index].id, quantity: self.quantity)
                        self.showingSheet = false
                        self.quantity = 1
                        self.itemsController.getItems()
                        self.showingAlert = true
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
        }
        .navigationTitle(category)
        .alert(isPresented: self.$showingAlert) {
            Alert(title: Text("La salida se ha registrado correctamente."))
        }
        .onAppear {
            self.itemsController.getItems()
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(
        color: Colors.blue,
        category: "Cocina")
    }
}
