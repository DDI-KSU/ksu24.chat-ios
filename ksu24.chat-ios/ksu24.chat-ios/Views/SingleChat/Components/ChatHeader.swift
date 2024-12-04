//
//  ChatHeader.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

// TODO: change objects' position/alignment
// TODO: fix avatar in private chats
struct ChatHeader: View {
    public var chat:    Chat
    
    public var chatManager: ChatManager
    
    @Environment(\.profileID) var currentUserID
    
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
        VStack {
                if chatType == .PRIVATE {
                    let member = chatManager.getChatPartnerID(currentUserID: currentUserID!)
                    HStack {
                        avatar(from: member.image)
                        
                        VStack(alignment: .leading) {
                            title
                                .font(.system(size: 22).bold())
                                .foregroundStyle(Color(.black))
                                
                                .offset(y: 3)
                            
                            lastSeenDate(from: chat.lastMessage.sender?.lastActivity)
                        }
                    }
                
            } else {
                HStack {
                    avatar(from: chat.image)
                    
                    title
                        .font(.headline)
                        .foregroundStyle(Color(.systemGray))
                    
                    Spacer()
                }
            }
            
//            headerDivider
        }
        .frame(minWidth: 72)
        .offset(x: -10)
    }
    
    @ViewBuilder
    private func avatar(from image: String?) ->  some View {
        if let urlString = image, let url = URL(string: urlString) {
            AsyncWebImage(
                url: url,
                placeholder: AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar(), frameSize: 40),
                size: 40
            )
                .padding(.trailing, 5)
        } else {
            AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar(), frameSize: 40)
        }
    }
    
    private var title: some View {
        Text(chat.name)
            
    }
    
    @ViewBuilder
    private func lastSeenDate(from date: String?) -> some View {
        if let date = parseDateString(chat.lastMessage.sender?.lastActivity ?? "") {
            Text("last seen: \(date.previewDate())")
                .font(.subheadline)
                .lineLimit(1)
                .foregroundStyle(Color(.systemGray))
        }
    }
    
    private var headerDivider: some View {
        Divider()
            .frame(width: UIScreen.main.bounds.width)
            .foregroundColor(Color(.systemGray5))
            .offset(y: -2)
    }
}
        
   



//#Preview {
//    ChatHeader()
//}
