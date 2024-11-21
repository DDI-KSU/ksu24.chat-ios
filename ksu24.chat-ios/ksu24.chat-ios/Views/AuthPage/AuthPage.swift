//
//  AuthPage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct AuthPage: View {
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                EnrollButton
            }
            .padding(.horizontal, 12)
            
            NavigationStack {
                LoginForm(authManager: authManager)
            }
            
            RecoverPasswordButton
        }
    }
    
    private var EnrollButton: some View {
        Link("Enroll", destination: URL(string: "https://ksu24.kspu.edu/registration")!)
            .padding(12)
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var RecoverPasswordButton: some View {
        Button(action: {
            
        }, label: {
            Text("Forgot Password?")
                .foregroundStyle(.gray)
            Text("Tap to Recover")
        })
    }
}

#Preview {
    AuthPage(authManager: AuthManager())
}
