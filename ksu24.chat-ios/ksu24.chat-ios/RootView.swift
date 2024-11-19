//
//  ContentView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/11/2024.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var authManager = AuthManager()
    @ObservedObject var chatManager = ChatManager()
        
    var body: some View {
        if authManager.isLoggedIn {
           HomePage(chatManager: chatManager, authManager: authManager)
        } else {
            AuthPage(authManager: authManager)
        }
    }
}

#Preview {
    RootView()
}
