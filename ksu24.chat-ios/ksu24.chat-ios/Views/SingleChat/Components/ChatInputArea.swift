//
//  ChatInputArea.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 23/11/2024.
//

import SwiftUI

struct ChatInputArea: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
//            Divider()
//                .offset(y: 18)
            
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
        Button {
            
        } label: {
            Text("Send")
                .foregroundStyle(text.isEmpty ? Color(.systemGray3) : .blue)
        }
        .disabled(text.isEmpty)
    }
}

#Preview {
    ChatInputArea()
}
