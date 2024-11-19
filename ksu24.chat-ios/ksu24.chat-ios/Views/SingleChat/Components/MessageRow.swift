//
//  Message.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct MessageRow: View {
    var message: Message
    
    var body: some View {
        HStack {
//            if message.isFromCurrentUser {
//                Spacer()
//
//                Text(message.text)
//                    .padding(12)
//                    .background(Color.blue)
//                    .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser))
//                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
//            } else {
//                HStack(alignment: .bottom) {
//                    Image(systemName: "person")
//
//                    Text(message.text)
//                        .padding(12)
//                        .background(Color(.systemGray5))
//                        .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser))
//                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
//
//                    Spacer()
//                }
//            }
            
            Spacer()
            
            Text(message.content)
                .padding(12)
                .background(Color.blue)
                .clipShape(ChatBubble())
                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            
                
        }
        .padding(.horizontal, 8)
    }
}

//#Preview {
//    Message()
//}
