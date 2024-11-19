//
//  MessageList.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct MessageList: View {
    public var messages: [Message]
    
    var body: some View {
        ScrollView {
                ForEach(messages) { message in
                    MessageRow(message: message)
                }
            }
            Spacer()
    }
}

//#Preview {
//    MessageList()
//}
