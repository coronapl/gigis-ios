//
//  LoanView.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import SwiftUI

struct LoanView: View {
    @State var loan: Loan
    var body: some View {
        VStack(alignment: .leading) {
            Text(loan.item.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(loan.quantity) \(loan.item.measurementUnit)", systemImage: "number")
                    .accessibilityElement(children: .ignore)
                Spacer()
                Label(loan.item.category.name, systemImage: "folder")
                    .padding(.trailing, 20)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct LoanView_Previews: PreviewProvider {
    static var previews: some View {
        LoanView(loan: Loan(
            id: 1,
            quantity: 5,
            loanedAt: "15-10-2021",
            returnedAt: nil,
            itemId: 1,
            userId: 1,
            user: User(
                id: 1,
                name: "Pedro Ortiz",
                employeeId: 1,
                phoneNumber: "4421231234",
                createdAt: nil,
                updatedAt: nil
            ),
            item: LoanItem(
                id: 1,
                name: "Tijeras",
                quantity: 5,
                measurementUnit: "Piezas",
                canBeLoaned: 1,
                categoryId: 1,
                category: Category(
                    id: 1,
                    name: "Papeleria",
                    icon: "Scissors")
            )
        ))
            .background(Colors.blue)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
