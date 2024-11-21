//
//  ChatHeader.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct ChatHeader: View {
    public var chat:    Chat
//    public var members: [Member]
    
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
        HStack {
            if chatType == .PRIVATE {
                let member = chatManager.getChatPartnerID(currentUserID: currentUserID!)
                
                if let stringUrl =  member.image {
                    if let url = URL(string: stringUrl) {
                        AsyncWebImage(url: url, placeholder: AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar()))
                    }
                } else {
                    AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar())
                        .frame(width: 60, height: 60)
                }
                
                
                VStack(alignment: .leading) {
                    Text(chat.name)
                        .font(.headline)
                        .foregroundStyle(Color(.systemGray))
                    
                    Text(chat.lastMessage.sender?.lastActivity ?? "Online")
                        .font(.subheadline)
                        .foregroundStyle(Color(.systemGray))
                    
                        
                }
                
                Spacer()
            } else {
                if let stringUrl = chat.image {
                    if let url = URL(string: stringUrl) {
                        AsyncWebImage(url: url, placeholder: AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar()))
                    }
                } else {
                    AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar())
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                }
                
                
                VStack(alignment: .leading) {
                    Text(chat.name)
                        .font(.headline)
                        .foregroundStyle(Color(.systemGray))
                }
                
                Spacer()
            }
            

        }
        .frame(minWidth: 72)
        .padding(.horizontal, 12)
        
      
    }

}
        
   



//#Preview {
//    ChatHeader()
//}
