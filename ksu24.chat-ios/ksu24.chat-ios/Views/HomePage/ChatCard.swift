//
//  ChatCard.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct ChatCard: View {
    var chat: Chat
    
    var body: some View {
        HStack {
            if let stringUrl = chat.image {
                AsyncImage(url: URL(string: stringUrl)) { image in
                    image.image?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(Color(.systemGray2))
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
                    .foregroundStyle(Color.black)
                    .lineLimit(1)
                
                Text(chat.lastMessage?.content ?? "Send your first message")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            Spacer()
            
            Text(chat.lastMessage?.created ?? "Today")
                .font(.caption)
                .foregroundStyle(Color.gray)
                .lineLimit(1)
                
        }
        .padding(.horizontal, 12)
        .frame(height: 72)
    }
}


//#Preview {
//    ChatCard()
//}
