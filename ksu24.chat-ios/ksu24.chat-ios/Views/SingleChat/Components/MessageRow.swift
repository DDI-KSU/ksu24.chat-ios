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
    
    var body: some View {
       
            if message.isFromCurrentUser(currentUserID: currentUserID) {
                HStack {
                    Spacer()
                    
                    if !message.attachments.isEmpty {
                        ForEach(message.attachments, id: \.file) { attachment in
                            AttachmentView(attachment: attachment, message: message, currentUserID: currentUserID)
                                .background(Color(.systemGray5))
                                .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                        }
                    }
                    
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        if let reply =  message.replyTo  {
                            VStack(alignment: .leading, spacing: 0) {
                                
                                
                                
                                Text(reply.sender.fullName)
                                    .foregroundStyle(Color.random())
                                    .lineLimit(1)
                                    .padding(5)
                                    .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: 10)
                                    .padding(.top, 3)
                                
                                
                                Text(reply.content)
                                    .lineLimit(1)
//                                    .frame(maxWidth: UIScreen.main.bounds.width / 1.75)
                                    .padding(5)
                                    .foregroundStyle(.white)
                                
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width * 0.5 , height: 1, alignment: .bottomLeading)
                                    .foregroundColor(Color(.white))
//                                    .padding(.leading, 12)
                                    
                            }
                            .background(Color.white.opacity(0.1))
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                            .padding(.top, 5)
                           
                        }
                        Text(message.content)
                            .padding(12)
                            .foregroundStyle(.white)
                    }
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                }
                .padding(.horizontal, 5)
            } else {
                
                HStack(alignment: .bottom, spacing: 0) {
                    if !chat.isPrivate && !chat.isChannel {
                        if let urlString = message.sender.image, let url = URL(string: urlString) {
                            AsyncWebImage(url: url, placeholder: AvatarPlaceHolder(letters: message.sender.fullName.takeLettersForAvatar(), frameSize: 20))
                                .padding(.trailing, 5)
                        }
                        
                    }
                    
                    if !message.attachments.isEmpty {
                        ForEach(message.attachments, id: \.file) { attachment in
                            AttachmentView(attachment: attachment, message: message, currentUserID: currentUserID)
                                .background(Color(.systemGray5))
                                .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                        }
                    } else {
                        GeometryReader { replyGeometry in
                            VStack(spacing: 0) {
                                if !chat.isPrivate && !chat.isChannel {
                                    Text(message.sender.fullName)
                                        .foregroundStyle(Color.random())
                                        .padding(.top, 5)
                                        .padding(.horizontal, 5)
                                        .lineLimit(1)
                                }
                                
                            
                                Text(message.content)
                                    .padding(.horizontal, 12)
                                    .frame(minHeight: 35, alignment: .leading)
                                
                            }
                            .background(Color(.systemGray5))
                            .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 5)
            }
            
            Spacer()
        }
        
    
}

//#Preview {
//    Message()
//}
