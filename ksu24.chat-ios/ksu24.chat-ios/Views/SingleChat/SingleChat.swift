//
//  SingleChatView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct SingleChat: View {
    @ObservedObject public var chatManager: ChatManager
    
    @State public var chat: Chat
    @State public var currentUserID: UUID
    
    @State public var text: String = ""
    
    
    
    var body: some View {
        VStack {
            ChatHeader(chat: chat, chatManager: chatManager)
            MessageList(messages: chatManager.messages, currentUserID: currentUserID)
            
            HStack {
                TextField("Enter message..", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                }
                .disabled(text.isEmpty)
            }
            .padding()
        }
        .onAppear {
            chatManager.loadMessages(withID: chat.id)
            chatManager.loadMembers(withID: chat.id)
        }
    }
}

//#Preview {
//    SingleChat(chatManager: ChatManager())
//}
