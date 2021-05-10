//
//  ItemsView.swift
//  gigis-ios
//
//  Created by Pablo V on 04/05/21.
//

import SwiftUI

struct ItemsView: View {

    @State var items = [Item]()
    
    func getItems() {
        guard let endpoint = URL(string: Environment.apiUrl.appending("items")) else {
            return
        }

        let defaults = UserDefaults.standard
        let token: String = defaults.string(forKey: "token")!
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }

            guard let itemsResponse = try? JSONDecoder().decode([Item].self, from: data) else {
                return
            }

            DispatchQueue.main.async {
                self.items = itemsResponse
            }
        }.resume()
    }

    // Filter items by category
    var kitchenCategory: [Item] {
        items.filter { item in
            (item.category == "Cocina" && item.quantity > 0)
        }
    }

    var learningCategory: [Item] {
        items.filter { item in
            (item.category == "Didáctico" && item.quantity > 0)
        }
    }

    var cleaningCategory: [Item] {
        items.filter { item in
            (item.category == "Limpieza" && item.quantity > 0)
        }
    }

    var gamesCategory: [Item] {
        items.filter { item in
            (item.category == "Juegos" && item.quantity > 0)
        }
    }

    var body: some View {
        TabView {
            CategoryView(items: cleaningCategory, color: Colors.orange, title: "Limpieza", icon: "hands.sparkles")
            CategoryView(items: learningCategory, color: Colors.blue, title: "Didáctico", icon: "scissors")
            CategoryView(items: gamesCategory, color: Colors.green, title: "Juegos", icon: "gamecontroller")
            CategoryView(items: kitchenCategory, color: Colors.yellow, title: "Cocina", icon: "leaf")
        }
        .onAppear(perform: getItems)
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
