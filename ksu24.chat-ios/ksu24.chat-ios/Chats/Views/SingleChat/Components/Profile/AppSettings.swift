//
//  AppSettings.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 11/12/2024.
//

import SwiftUI

struct AppSettings: View {
    @ObservedObject public var authManager: AuthManager
    
    var body: some View {
            List {
                Section {
                    navigationRow(name: "Notifications",    color: .blue,   icon: "bell")
                    
                    NavigationLink(destination: DataAndStorage()) {
                        navigationRow(name: "Data and Storage",  color: .green,  icon: "chart.pie")
                    }

                    navigationRow(name: "Themes", color: .yellow, icon: "paintbrush")
                }
                
                Section {
                    navigationRow(name: "Language", color: .purple,    icon: "globe")
                    navigationRow(name: "FAQ",      color: .orange, icon: "questionmark.square")
                }
                
                Section {
                    Button {
                        authManager.logout()
                        authManager.isLoggedIn = false
                    } label: {

                        navigationRow(name: "Logout", color: .red, icon: "door.right.hand.open")
                    }
                  
                }
            }
      
    }
    
    private func navigationRow(name: String, color: Color, icon: String) -> some View {
        HStack {
            Image(systemName: "\(icon)")
                .foregroundStyle(.white)
                .padding(3)
                .frame(width: 25, height: 25)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            Text("\(name)")
                .padding(.leading, 5)
        }
    }
}
//
//#Preview {
//    AppSettings()
//}
