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
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser(currentUserID: currentUserID) {
                Spacer()

                Text(message.content)
                    .padding(12)
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom) {
                    Image(systemName: "person")

                    Text(message.content)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)

                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}

//#Preview {
//    Message()
//}
