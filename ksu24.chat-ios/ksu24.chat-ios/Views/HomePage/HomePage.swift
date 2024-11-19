//
//  HomePage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject public var chatManager: ChatManager
    @ObservedObject public var authManager: AuthManager
    
    @State private var chatNameSearch = ""
    @State private var filteredChats: [Chat] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(chatNameSearch.isEmpty ? chatManager.chats : filteredChats, id: \.id) { chat in
                        NavigationLink(value: chat) {
                            ChatCard(chat: chat)
                        }
                        
                    }
                }
            }
            .onAppear {
                chatManager.loadChats()
            }
            .navigationDestination(for: Chat.self) { chat in
                SingleChat(chatManager: chatManager, chat: chat)
            }
        }
        .searchable(text: $chatNameSearch,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("Search for chat")
        )
    }

    
    private var chatsToDisplay: [Chat] {
        chatNameSearch.isEmpty ? chatManager.chats : filteredChats
    }
        
       
    private func filterChats() {
        if chatNameSearch.isEmpty {
            filteredChats = chatManager.chats
        } else {
            filteredChats = chatManager.chats.filter { chat in
                chat.name.localizedCaseInsensitiveContains(chatNameSearch)
            }
        }
    }
}

#Preview {
    HomePage(chatManager: .init(), authManager: .init())
}
