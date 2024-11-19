//
//  AuthPage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct AuthPage: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            LoginForm(authManager: _authManager)
        }
    }
}

//#Preview {
//    AuthPage(authManager: AuthManager())
//}
