//
//  Message.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

// TODO: Replying gesture
// TODO: Show message views / list of reactions
// TODO: Username on messages in group chats
// TODO: Poll view
// TODO: sent date
// TODO: message has been seen / sent
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
    
    private var isReactionAttached: Bool {
        !message.reactions.isEmpty
    }
    
    private var isReactionFromCurrentUser: Bool {
        message.reactions.contains(where: { $0.person.id == currentUserID })
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
            
                if isReactionAttached {
                    reactions(from: message)
                        .padding(.horizontal, 3)
                        .padding(.bottom, 3)
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
    
    @ViewBuilder
    private func reactions(from message: Message) -> some View {
        let reactionsString: [String] = message.reactions.map { $0.reaction }
        
        let mappedReaction = reactionsString.map { ($0, 1) }
        
        let counts = Dictionary(mappedReaction, uniquingKeysWith: +)
        
        HStack {
            ForEach(Array(counts.keys), id: \.self) { reaction in
                if let count = counts[reaction] {
                    
                    Text(reaction + " \(count)")
                        .padding(3)
                        .background(
                            isFromCurrentUser ? Color.white.opacity(isReactionFromCurrentUser ? 1 : 0.1) :
                                Color.blue.opacity(isReactionFromCurrentUser ? 1 : 0.1))
                        .clipShape(Capsule())
                    //                .frame(maxWidth: 20, maxHeight: )
                }
            }
        }
    }
}

//#Preview {
//    Message()
//}
