//
//  LoginView.swift
//  gigis-ios
//
//  Created by Pablo V on 01/05/21.
//

import SwiftUI

struct LoginView: View {

    var authService: AuthService
    @ObservedObject var loginController: LoginController

    init(authService: AuthService) {
        self.authService = authService
        self.loginController = LoginController(authService: self.authService)
    }

    var body: some View {
        ZStack {
            Colors.blue.ignoresSafeArea()
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .padding()
                    .padding(.bottom, 80)
                    .frame(width: 242, height: 206, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Sistema de inventario")
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 20)
                TextField("Celular", text: self.$loginController.phoneNumber)
                    .padding()
                    .background(Colors.lightGrey)
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                SecureField("Contraseña", text: self.$loginController.password)
                    .padding()
                    .background(Colors.lightGrey)
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                Text(self.loginController.errorMessage)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                Button(action: { self.loginController.login() }, label: {
                    Text("Iniciar sesión")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Colors.orange)
                        .cornerRadius(35)
                        .padding(.bottom, 20)
                })
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(authService: AuthService())
        }
    }
}
