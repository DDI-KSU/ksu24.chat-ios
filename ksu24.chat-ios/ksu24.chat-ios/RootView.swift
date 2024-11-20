//
//  ContentView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/11/2024.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var authManager: AuthManager
    @ObservedObject var chatManager: ChatManager
    @ObservedObject var profileManager: ProfileManager
    
        
    var body: some View {
        Group {
            if authManager.isLoggedIn {
               HomePage(chatManager: chatManager, profileManager: profileManager)
            } else {
                AuthPage(authManager: authManager)
            }
        }
        .onChange(of: authManager.isLoggedIn) {
            profileManager.loadProfile()
        }
        
    }
}

//#Preview {
//    RootView()
//}
