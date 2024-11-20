//
//  ChatHeader.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct ChatHeader: View {
    public var chat:    Chat
    public var members: [Member]
    
    @Environment(\.profileID) var currentUserID
    
    private var chatPartner: Member? {
        members.first(where: { $0.id != currentUserID })
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
        HStack {
            if chatType == .PRIVATE {
                
                if let stringUrl = chatPartner?.image {
                    if let url = URL(string: stringUrl) {
                        AsyncWebImage(url: url, placeholder: PlaceHolder())
                    }
                } else {
                    PlaceHolder()
                        .frame(width: 60, height: 60)
                }
                
                
                VStack(alignment: .leading) {
                    Text(chat.name)
                        .font(.headline)
                        .foregroundStyle(Color(.systemGray))
                    
                    Text(chat.lastMessage?.sender?.lastActivity ?? "Online")
                        .font(.subheadline)
                        .foregroundStyle(Color(.systemGray))
                    
                    Spacer()
                }
            } else {
                if let stringUrl = chat.image {
                    if let url = URL(string: stringUrl) {
                        AsyncWebImage(url: url, placeholder: PlaceHolder())
                    }
                } else {
                    PlaceHolder()
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
