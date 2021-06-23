//
//  LoansView.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import SwiftUI
import PartialSheet

struct LoansView: View {

    @StateObject var loansController: LoansContoller = LoansContoller()
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var partialSheet : PartialSheetManager
    @State private var showingAlert = false

    let colors = [Colors.blue, Colors.orange, Colors.green, Colors.yellow, Colors.pink, Colors.aqua]

    var body: some View {
        NavigationView {
            List(self.loansController.loans.indices, id: \.self) { index in
                Button(action: {
                    self.partialSheet.showPartialSheet {
                        print("dismissed")
                    } content: {
                        VStack {
                            Text("¿Quiéres regresar el siguiente préstamo?")
                                .font(.headline)
                                .padding(.bottom)
                            Text("Artículo: \(self.loansController.loans[index].item.name)")
                                .font(.caption)
                            Text("Cantidad: \(self.loansController.loans[index].quantity)")
                                .font(.caption)
                            Button(action: {
                                self.loansController.returnPersonalLoan(loanId: self.loansController.loans[index].id)
                                self.partialSheet.closePartialSheet()
                                self.showingAlert = true
                            }, label: {
                                Text("Regresar")
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
                    VStack(alignment: .leading) {
                        Text(self.loansController.loans[index].item.name)
                            .font(.headline)
                        Spacer()
                        HStack {
                            Label("\(self.loansController.loans[index].quantity) \(self.loansController.loans[index].item.measurementUnit)", systemImage: "number")
                                .accessibilityElement(children: .ignore)
                            Spacer()
                            Label(self.loansController.loans[index].item.category!.name, systemImage: "folder")
                                .padding(.trailing, 20)
                        }
                        .font(.caption)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(colors[index % 6])
                })
            }
            .navigationTitle("Mis préstamos")
            .navigationBarItems(trailing: Button(action: {
                self.authService.logout()
            }, label: {
                Text("Salir")
            }))
        }
        .addPartialSheet()
        .alert(isPresented: self.$showingAlert) {
            Alert(title: Text("El préstamo se ha regresado correctamente."))
        }
        .onAppear {
            self.loansController.getPersonalLoans()
        }
    }
}


struct LoansView_Previews: PreviewProvider {
    static var previews: some View {
        LoansView()
    }
}
