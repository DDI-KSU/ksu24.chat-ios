//
//  HomePage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

// TODO: Profile page
// TODO: Activate create new chat button
// TODO: Fix search mechanic
// TODO: search bar pull out
struct HomePage: View {
    @ObservedObject public var chatManager:     ChatManager
    @ObservedObject public var profileManager:  ProfileManager
    
    @State private var searchText: String  = ""
    @State private var filteredChats: [Chat] = []
    
    @State private var SBisShown: Bool = false

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onChanged { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                case (...0, -30...30):  print("left swipe")
                case (0..., -30...30):  print("right swipe")
                case (-100...100, ...0):
                    withAnimation {
                        SBisShown = false
                    }
                
                case (-100...100, 0...):
                    withAnimation {
                        SBisShown = true
                    }
                default:  print("no clue")
                }
            }
    }
    
    var body: some View {
        VStack(spacing: 0) {
                    
            chatsList
                .onAppear {
                    chatManager.loadChats()
                }
                
            }
        }

    @ViewBuilder
    private var chatsList: some View {
        NavigationStack {
            header
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    if SBisShown {
                        SearchBar(searchText: $searchText)
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: 10)
                            .transition(
                                 .asymmetric(
                                  insertion: .push(from: .top),
                                  removal: .push(from: .bottom)
                                 )
                                )
                            .padding()
                    }
                    
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
                .simultaneousGesture(dragGesture)
            }
        }
        
        
    }
    
    @ViewBuilder
    private var header: some View {
        VStack {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .foregroundStyle(.blue)
                    .padding(.leading, 15)
                
                Spacer()
                
                Text("KSU Chat")
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "square.and.pencil")
                    .foregroundStyle(.blue)
                    .padding(.trailing, 15)
            }
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
