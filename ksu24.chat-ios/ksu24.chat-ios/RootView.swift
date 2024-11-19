//
//  ContentView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/11/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var chatManager: ChatManager
    @EnvironmentObject var profileManager: ProfileManager
    
        
    var body: some View {
        Group {
            if authManager.isLoggedIn {
               HomePage()
            } else {
                AuthPage()
            }
        }
        .onChange(of: authManager.isLoggedIn) {
            profileManager.loadProfile()
        }
        
    }
}

#Preview {
    RootView()
}
