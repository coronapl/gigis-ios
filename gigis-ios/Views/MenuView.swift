//
//  MenuView.swift
//  gigis-ios
//
//  Created by Pablo V on 21/05/21.
//

import SwiftUI

struct MenuView: View {

    @EnvironmentObject var authService: AuthService

    var body: some View {
        TabView {
            CategoriesView()
                .tabItem {
                    Label("Sacar", systemImage: "square.and.arrow.up")
                }
            Text("Regresar")
                .tabItem {
                    Label("Regresar", systemImage: "square.and.arrow.down")
                }
        }
    }
}

struct CardView: View {
    var image: String
    var title: String
    var description: String

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
            VStack(alignment: .leading) {
                Text(title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(description)

            }
            .padding()
            .frame(width: 330)
        }
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuView()
        }
    }
}
