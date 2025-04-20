//
//  MessageList.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct MessageList: View {
    public var messages: [Message]
    public var currentUserID: UUID
    
    public var chat: Chat
    
    @Binding var isReplying: Bool
    @Binding var replyToMessage: Message?
    
    var body: some View {
        Divider()
        
        ScrollView {
            Spacer()
            
            ForEach(messages.reversed()) { message in
                MessageRow(
                    message:        message,
                    currentUserID:  currentUserID,
                    isReplying:     $isReplying,
                    replyToMessage: $replyToMessage,
                    chat:           chat)
                }
            }
    }
}

//#Preview {
//    MessageList()
//}
