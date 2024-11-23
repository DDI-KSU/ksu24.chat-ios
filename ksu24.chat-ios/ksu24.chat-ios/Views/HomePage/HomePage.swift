//
//  HomePage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct HomePage: View {
   
    
    @ObservedObject public var chatManager:     ChatManager
    @ObservedObject public var profileManager:  ProfileManager
    
    @State private var searchText: String  = ""
    @State private var filteredChats: [Chat] = []

    
    var body: some View {
        VStack(spacing: 0) {
            
            header
                    
            chatsList
                .onAppear {
                    chatManager.loadChats()
                }
                
            }
        }

    @ViewBuilder
    private var chatsList: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(searchText.isEmpty ? chatManager.chats : filteredChats, id: \.id) { chat in
                        NavigationLink(value: chat) {
                            ChatCard(chat: chat)
                        }
                    }
                }
                .navigationDestination(for: Chat.self) { chat in
                    SingleChat(
                        chatManager: chatManager,
                        chat: chat,
                        currentUserID: profileManager.profile.id
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    private var header: some View {
        HStack(spacing: 0) {
            Image(systemName: "line.horizontal.3")
                .foregroundStyle(.blue)
            
            SearchBar(searchText: $searchText)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: 10)
                .padding()
            
            Image(systemName: "square.and.pencil")
                .foregroundStyle(.blue)
        }
    }
    
    private var chatsToDisplay: [Chat] {
        searchText.isEmpty ? chatManager.chats : filteredChats
    }
        
       
    private func filterChats() {
        if searchText.isEmpty {
            filteredChats = chatManager.chats
        } else {
            filteredChats = chatManager.chats.filter { chat in
                chat.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
//#Preview {
//    HomePage(chatManager: .init(), authManager: .init())
//}
