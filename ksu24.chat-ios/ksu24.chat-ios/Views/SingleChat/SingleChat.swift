//
//  SingleChatView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

// TODO: load all of messages
struct SingleChat: View {
    @ObservedObject public var chatManager: ChatManager
    
    @State public var chat: Chat
    @State public var currentUserID: UUID
    
    @State public var text: String = ""

    var body: some View {
        VStack(spacing: 0) {
//            Spacer()
            
            MessageList(messages: chatManager.messages, currentUserID: currentUserID, chat: chat)
//                .offset(y: 20)
               
            ChatInputArea(text: text)
           
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChatHeader(chat: chat, chatManager: chatManager)
            }
        }
        .onAppear {
            chatManager.loadMessages(withID: chat.id)
            chatManager.loadMembers(withID: chat.id)
            
            if !chat.isPrivate {
                chatManager.loadSurveys(withID: chat.id)
            }
        }
    }
}

//#Preview {
//    SingleChat(chatManager: ChatManager())
//}
