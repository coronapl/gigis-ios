//
//  ItemsController.swift
//  gigis-ios
//
//  Created by Pablo V on 21/05/21.
//

import Foundation

class ItemsController: ObservableObject {

    @Published var items: [String: [Item]] = [:]

    init() {
        // Get the items from the API on init
        self.getItems()
    }

    public func getItems() -> Void {
        ItemApi.all { result in
            switch(result) {
                case .success(let items):
                    DispatchQueue.main.async {
                        // Create dictionary -> category => [items]
                        for item in items {
                            if item.category != nil {
                                if self.items.keys.contains(item.category!.name) {
                                    self.items[item.category!.name]!.append(item)
                                } else {
                                    self.items[item.category!.name] = []
                                    self.items[item.category!.name]!.append(item)
                                }
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }

    public func takeItem(id: Int, quantity: Int) {
        ItemApi.takeItem(id: id, quantity: quantity) { result in
            switch(result) {
                case .success(let apiResponse):
                    print(apiResponse)
                    DispatchQueue.main.async {
                        self.getItems()
                    }
                case .failure(let error):
                    print(error)
            }
        }

    }
}
