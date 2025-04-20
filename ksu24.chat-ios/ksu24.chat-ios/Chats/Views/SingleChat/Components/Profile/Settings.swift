//
//  Settings.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 10/12/2024.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var profileManager: ProfileManager
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileInfo(profileManager: profileManager)
                
                Spacer()
                
                AppSettings(authManager: authManager)
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    Settings()
//}
