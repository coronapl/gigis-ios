//
//  LoansView.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import SwiftUI

struct LoansView: View {
    @StateObject var loansController: LoansContoller = LoansContoller()
    @EnvironmentObject var authService: AuthService

    var body: some View {
        NavigationView {
            List(self.loansController.loans, id: \.id) { loan in
                LoanView(loan: loan)
                    .background(Colors.green)
            }
            .navigationTitle("Mis préstamos")
            .navigationBarItems(trailing: Button(action: {
                self.authService.logout()
            }, label: {
                Text("Salir")
            }))
        }
    }
}

struct LoansView_Previews: PreviewProvider {
    static var previews: some View {
        LoansView()
    }
}
