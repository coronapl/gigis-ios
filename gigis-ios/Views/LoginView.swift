//
//  LoginView.swift
//  gigis-ios
//
//  Created by Pablo V on 01/05/21.
//

import SwiftUI

let blue = Color(red: 72 / 255, green: 140 / 255, blue: 203 / 255)
let orange = Color(red: 245 / 250, green: 130 / 255, blue: 32 / 255)
let lightGrey = Color(red: 239 / 255, green: 243 / 255, blue: 244 / 255)

struct LoginView: View {

    @ObservedObject private var loginViewModel = LoginViewModel()

    var body: some View {
        ZStack {
            blue.ignoresSafeArea()
            VStack {
                LogoImage()
                LoginTitle()
                EmailInput(email: self.$loginViewModel.email)
                PasswordInput(password: self.$loginViewModel.password)
                ErrorMessage(errorMessage: self.$loginViewModel.errorMessage)
                Button(action: { loginViewModel.login() }, label: {
                    LoginButtonContent()
                })
            }
            .padding()
        }
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("Iniciar sesión")
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(.white)
            .background(orange)
            .cornerRadius(35)
            .padding(.bottom, 20)
    }
}

struct LogoImage: View {
    var body: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .padding()
            .padding(.bottom, 80)
            .frame(width: 242, height: 206, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct LoginTitle: View {
    var body: some View {
        Text("Sistema de inventario")
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(.white)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding(.bottom, 20)
    }
}

struct EmailInput: View {
    @Binding var email: String
    var body: some View {
        TextField("Email", text: $email)
            .padding()
            .background(lightGrey)
            .cornerRadius(5)
            .padding(.bottom, 20)
    }
}

struct PasswordInput: View {
    @Binding var password: String
    var body: some View {
        SecureField("Contraseña", text: $password)
            .padding()
            .background(lightGrey)
            .cornerRadius(5)
            .padding(.bottom, 20)
    }
}

struct ErrorMessage: View {
    @Binding var errorMessage: String
    var body: some View {
        Text(errorMessage)
            .padding(.bottom, 20)
            .foregroundColor(.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}
