//
//  LoginForm.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct LoginForm: View, SecuredTextFieldParentProtocol {
    @ObservedObject var authManager:    AuthManager
    
    @State public var username:     String = "000863"
    @State public var password:     String = "EN3QpQq2KT"
 
   
    @State var hideKeyboard: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            enterForm
                .padding(.horizontal)
            
           
            logInButton
                .offset(y: -8)
               
        }
    }
    
    private var enterForm: some View {
        GroupBox {
            HStack(spacing: 0) {
                Text("Welcome to ")
                    .font(.title2)

                Text("KSU Chat!")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .offset(y: -20)
            
            usernameTextField
            
            SecuredTextField(parent: self, text: $password)
               
        }
        .backgroundStyle(.clear)
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
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private var usernameTextField: some View {
        ZStack(alignment: .trailing) {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
                .padding(.bottom, 7)
                .textFieldStyle(.roundedBorder)
            
            Image(systemName: "person.circle")
                .renderingMode(.template)
                .foregroundStyle(Color(.systemGray2))
                .offset(x: -9, y: -2)
        }
    }
}

#Preview {
    LoginForm(authManager: AuthManager.init())
}
