//
//  Message.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct MessageRow: View {
    var message: Message
    var currentUserID: UUID
    
    var chat: Chat
    
    private var isFromCurrentUser: Bool {
        message.isFromCurrentUser(currentUserID: currentUserID)
    }
    
    private var isFileAttached: Bool {
        !message.attachments.isEmpty
    }
    
    var body: some View {
            HStack {
                if isFromCurrentUser {
                    Spacer()
                }
                
                VStack(alignment: isFromCurrentUser ? .trailing : .leading) {
                    if let reply =  message.replyTo  {
                        replyView(from: reply)
                            .background(Color.white.opacity(0.1))
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                            .padding(.top, 5)
                    }
                    
                    if isFileAttached {
                        ForEach(message.attachments, id: \.file) { attachment in
                            attachmentView(attachment: attachment)
                        }
                    }
                    
                    if !isFileAttached {
                        messageContent
                    }
                }
                .background(isFromCurrentUser ? Color.blue : Color(.systemGray5))
                .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                
                if !isFromCurrentUser {
                    Spacer()
                }
                    
            }
            .padding(.horizontal, 5)
        
        Spacer()
    }
        
    @ViewBuilder
    private func attachmentView(attachment: File) -> some View {
        AttachmentView(attachment: attachment, message: message, currentUserID: currentUserID)
            .background(isFromCurrentUser ? Color(.blue) : Color(.systemGray5))
            .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
    }
    
    @ViewBuilder
    private func replyView(from reply: Reply) ->  some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(reply.sender.fullName)
                .foregroundStyle(Color.white)
                .lineLimit(1)
                .padding(5)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 10)
                .padding(.top, 3)
            
            Text(reply.content)
                .lineLimit(1)
                .padding(5)
                .foregroundStyle(isFromCurrentUser ? .white : .black)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.5 , height: 1, alignment: .bottomLeading)
                .foregroundColor(Color(.white))
        }
    }
    
    private var messageContent: some View {
        Text(message.content)
            .padding(12)
            .foregroundStyle(isFromCurrentUser ? .white : .black)
    }
    
    @ViewBuilder
    private func avatar(from image: String?) ->  some View {
        if let urlString = message.sender.image, let url = URL(string: urlString) {
            AsyncWebImage(url: url, placeholder: AvatarPlaceHolder(letters: message.sender.fullName.takeLettersForAvatar(), frameSize: 20))
                .padding(.trailing, 5)
        }
    }
}

//#Preview {
//    Message()
//}
