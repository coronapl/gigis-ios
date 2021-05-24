//
//  LoansController.swift
//  gigis-ios
//
//  Created by Pablo V on 24/05/21.
//

import Foundation

class LoansContoller: ObservableObject {
    @Published var loans: [Loan] = []

    init() {
        self.getPersonalLoans()
    }

    public func getPersonalLoans() {
        LoanApi.all() { result in
            switch(result) {
                case .success(let loans):
                    DispatchQueue.main.async {
                        self.loans = loans
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
