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
    
    
    var body: some View {
        VStack {
            ChatHeader(chat: chat)
            MessageList(messages: chatManager.messages)
        }
        .onAppear {
            chatManager.loadMessages(withID: chat.id)
        }
    }
}

//#Preview {
//    SingleChat(chatManager: ChatManager())
//}
