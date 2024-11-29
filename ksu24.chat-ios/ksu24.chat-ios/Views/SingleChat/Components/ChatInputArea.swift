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
            //            Rectangle()
            //                .frame(width: UIScreen.main.bounds.width, height: 1)
            //                .foregroundColor(Color(.systemGray5))
            //                .offset(y: 8)
            Divider()
                .offset(y: 15)
            
            ZStack(alignment: .trailing) {
               
                TextField("Enter message..", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 15)
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "paperclip")
                    }
                    .padding(.trailing, 9)
                    
                    Button {
                        
                    } label: {
                        Text("Send")
                            .foregroundStyle(text.isEmpty ? Color(.systemGray3) : .blue)
                    }
                    .disabled(text.isEmpty)
                    
                }
                .padding(.trailing, 12)
                }
                
            .padding()
        }
        .ignoresSafeArea(.all)
        .frame(maxHeight: 30)
    }
}

#Preview {
    ChatInputArea()
}
