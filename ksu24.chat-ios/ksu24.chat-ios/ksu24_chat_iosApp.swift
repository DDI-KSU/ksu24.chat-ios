//
//  ksu24_chat_iosApp.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/11/2024.
//

import SwiftUI

@main
struct ksu24_chat_iosApp: App {
    var body: some Scene {
        WindowGroup {
            AuthPage(authManager: AuthManager())
        }
    }
}
