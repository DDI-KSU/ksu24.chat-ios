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
        VStack(spacing: 0) {
            HStack {
                avatar
                
                VStack(alignment: .leading) {
                    title
                    lastMessage
                }
                
                Spacer()
                
                if let date = parseDateString(chat.lastMessage.created) {
                    lastMessageDate(date)
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 72)
            
            GeometryReader { geometry in
                underlyingStrip(geometry: geometry)
            }
        }
    }
    
    private var title: some View {
        Text(chat.name)
            .font(.headline)
            .foregroundStyle(Color.black)
            .lineLimit(1)
    }
    
    private var lastMessage: some View {
        Text(chat.lastMessage.content)
            .font(.subheadline)
            .foregroundStyle(Color.gray)
            .lineLimit(1)
            .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
    }
    
    private func lastMessageDate(_ date: Date) ->  some View {
            Text(date.previewDate())
                .font(.caption)
                .foregroundStyle(Color.gray)
                .lineLimit(1)
    }
    
    private func underlyingStrip(geometry: GeometryProxy) -> some View {
        Rectangle()
            .frame(width: nil, height: 1, alignment: .bottomLeading)
            .foregroundColor(Color(.systemGray5))
            .padding(.leading, 12)
            .offset(x: geometry.size.width * 0.15)
    }
    
    @ViewBuilder
    private var avatar: some View {
        if let stringUrl = chat.image, let url = URL(string: stringUrl) {
            AsyncWebImage(
                url: url,
                placeholder: AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar(), frameSize: 60),
                size: 60
            )
        } else {
            AvatarPlaceHolder(letters: chat.name.takeLettersForAvatar(), frameSize: 60)
        }
    }
}
    
    
     



//#Preview {
//    ChatCard()
//}
