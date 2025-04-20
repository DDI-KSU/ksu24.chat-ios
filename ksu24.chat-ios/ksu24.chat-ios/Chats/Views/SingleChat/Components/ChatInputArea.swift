//
//  ChatInputArea.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 23/11/2024.
//

import SwiftUI
import PhotosUI

// TODO: Keyboard focus on replying
// TODO: send messages (WebSockets are required)
struct ChatInputArea: View {
    @State var text: String = ""
    @Binding public var isReplying: Bool
    @Binding public var replyToMessage: Message?
    
    @State private var photosPickerItems: [PhotosPickerItem] = []
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                inputBar
                
                HStack {
                    paperclipButton
                    
                    sendButton
                }
                .padding(.trailing, 12)
            }
            .padding()
        }
        .ignoresSafeArea(.all)
        .frame(maxHeight: 40)
    }
    
    private var inputBar: some View {
        TextField("Enter message..", text: $text)
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.leading, 15)
    }
    
    private var paperclipButton: some View {
        Button {
            
        } label: {
            Image(systemName: "paperclip")
        }
        .padding(.trailing, 9)
    }
    
    private var sendButton: some View {
        PhotosPicker("Send ", selection: $photosPickerItems, selectionBehavior: .ordered)
    }
    
    private var replyView: some View {
        HStack {
            VStack {
                Text(replyToMessage?.sender.fullName ?? "???")
                Text(replyToMessage?.content ?? "???")
            }
            
            Button {
                isReplying = false
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .border(Color.green)
    }
}

//#Preview {
//    ChatInputArea()
//}
