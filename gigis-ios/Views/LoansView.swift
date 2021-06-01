//
//  LoansView.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import SwiftUI
import PartialSheet

struct LoansView: View {
    @EnvironmentObject var loansController: LoansContoller
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var partialSheet : PartialSheetManager

    var body: some View {
        NavigationView {
            List(self.loansController.loans, id: \.id) { loan in
                Button(action: {
                    self.partialSheet.showPartialSheet {
                        print("dismissed")
                    } content: {
                        VStack {
                            Text("¿Quiéres regresar el siguiente préstamo?")
                                .font(.headline)
                                .padding(.bottom)
                            Text("Artículo: \(loan.item.name)")
                                .font(.caption)
                            Text("Cantidad: \(loan.quantity)")
                                .font(.caption)
                            Button(action: {
                                self.loansController.returnPersonalLoan(loanId: loan.id)
                                self.partialSheet.closePartialSheet()
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
                    LoanView(loan: loan)
                        .background(Colors.green)
                })
            }
            .navigationTitle("Mis préstamos")
            .navigationBarItems(trailing: Button(action: {
                self.authService.logout()
            }, label: {
                Text("Salir")
            }))
            .addPartialSheet()
            .onAppear {
                self.loansController.getPersonalLoans()
            }
        }
    }
}


struct LoansView_Previews: PreviewProvider {
    static var previews: some View {
        LoansView()
    }
}
