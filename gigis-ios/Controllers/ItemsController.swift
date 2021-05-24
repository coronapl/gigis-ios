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
                            if self.items.keys.contains(item.category) {
                                self.items[item.category]!.append(item)
                            } else {
                                self.items[item.category] = []
                                self.items[item.category]!.append(item)
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
