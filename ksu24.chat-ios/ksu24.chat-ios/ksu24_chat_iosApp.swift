//
//  ksu24_chat_iosApp.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/11/2024.
//

import SwiftUI

@main
struct ksu24_chat_iosApp: App {
    @StateObject var authManager: AuthManager = .init()
    @StateObject var chatManager: ChatManager = .init()
    
    var body: some Scene {
        WindowGroup {
            RootView(authManager: authManager,chatManager: chatManager)
        }
    }
}
