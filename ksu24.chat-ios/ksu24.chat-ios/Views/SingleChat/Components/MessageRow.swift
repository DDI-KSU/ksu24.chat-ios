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

                
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                if !message.attachments.isEmpty {
                    ForEach(message.attachments, id: \.file) { attachment in
                        AttachmentView(attachment: attachment, withText: message.content)
                                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                    }
                } else {
                    Text(message.content)
                        .padding(12)
                        .background(Color.blue)
                        .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                }
                
            } else {
                HStack(alignment: .bottom, spacing: 0) {
                    Image(systemName: "person")
                    
                    if !message.attachments.isEmpty {
                        ForEach(message.attachments, id: \.file) { attachment in
                            AttachmentView(attachment: attachment, withText: message.content)
                                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                        }
                    } else {
                        Text(message.content)
                            .padding(12)
                            .background(Color(.systemGray5))
                            .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser(currentUserID: currentUserID)))
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                    }
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
