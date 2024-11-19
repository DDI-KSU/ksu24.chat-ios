//
//  ChatHeader.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct ChatHeader: View {
    public var chat: Chat
    
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
                Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(Color(.systemGray2))
                
                
                VStack(alignment: .leading) {
                    Text(chat.name)
                        .font(.headline)
                        .foregroundStyle(Color(.systemGray))
                    
                    Text(chat.lastMessage?.sender?.lastActivity ?? "Online")
                        .font(.subheadline)
                        .foregroundStyle(Color(.systemGray))
                }
                
                Spacer()
            } else {
                if let stringUrl = chat.image {
                    AsyncImage(url: URL(string: stringUrl)) { image in
                        image.image?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                    }
                    
                   
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(Color(.systemGray2))
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
