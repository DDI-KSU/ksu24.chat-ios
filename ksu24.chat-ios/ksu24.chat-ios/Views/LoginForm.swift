//
//  LoginForm.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct LoginForm: View {
    @ObservedObject var authManager: AuthManager
    
    @State public var username: String = "000863"
    @State public var password: String = "EN3QpQq2KT"
    
    var body: some View {
        enterForm
            .padding(.horizontal)
        
       
        logInButton
    }
    
    private var enterForm: some View {
        GroupBox {
            Text("Welcome to KSU Chat!")
                .font(.title2)
            
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
        }
    }
    
    private var logInButton: some View {
        Button(action: {
            authManager.login(
                creditinals: .init(username: username, password: password)
            )
            
            authManager.isLoggedIn = true
        }) {
            Text("Log In")
                .padding(12)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
//    LoginForm(authManager: AuthManager.init())
}
