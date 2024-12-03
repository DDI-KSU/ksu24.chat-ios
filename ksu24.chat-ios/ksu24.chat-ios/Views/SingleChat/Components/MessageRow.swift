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
    
    private var chatType: ChatType {
        if chat.isPrivate {
            .PRIVATE
        } else if chat.isChannel {
            .CHANNEL
        } else {
            .GROUP
        }
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
                if isFromCurrentUser {
                    Spacer()
                }
                
                if chatType == .GROUP && !isFromCurrentUser {
                    avatar(from: message.sender.image)
                }
                
            VStack(alignment: isFromCurrentUser ? .trailing : .leading) {
                    if let reply =  message.replyTo  {
                        replyView(from: reply)
                            .background(isFromCurrentUser ? .white.opacity(0.1) : .blue.opacity(0.1))
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 16,
                                    topTrailingRadius: 16
                                )
                            )
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 50)
                            .padding(.top, 5)
                            .padding(.horizontal, 10)
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
                .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: isFromCurrentUser ? .trailing : .leading)
                
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
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 2, alignment: .bottomLeading)
                .foregroundColor(isFromCurrentUser ? .white : .blue)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(reply.sender.fullName)
                    .foregroundStyle(isFromCurrentUser ? .white : .black)
                    .bold()
                    .lineLimit(1)
                    .padding(5)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 10)
                    .padding(.top, 5)
                
                Text(reply.content)
                    .lineLimit(1)
                    .padding(5)
                    .foregroundStyle(isFromCurrentUser ? .white : .black)
            }
  
        }
    }
    
    private var messageContent: some View {
        Text(message.content)
            .padding(12)
            .foregroundStyle(isFromCurrentUser ? .white : .black)
    }
    
    @ViewBuilder
    private func avatar(from image: String?) ->  some View {
        if let urlString = image, let url = URL(string: "https://ksu24.kspu.edu/\(urlString)") {
            AsyncWebImage(
                url: url,
                placeholder: AvatarPlaceHolder(letters: message.sender.fullName.takeLettersForAvatar(), frameSize: 40),
                size: 40
            )
                .padding(.trailing, 5)
        } else {
            AvatarPlaceHolder(letters: message.sender.fullName.takeLettersForAvatar(), frameSize: 40)
        }
    }
}

//#Preview {
//    Message()
//}
