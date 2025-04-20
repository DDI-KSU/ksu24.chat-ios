//
//  SingleChatView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

// TODO: load all of messages
struct SingleChat: View {
    @ObservedObject public var chatManager: ChatManager
    @ObservedObject public var surveyManager: SurveyManager
    
    @Environment(\.isBottomTabBarHidden) var isBottomTabBarHidden
    @State public var chat: Chat
    @State public var currentUserID: UUID
    
    @State var isSurveysPresented = false
    
    @State public var text: String = ""
    
    @State public var isReplying: Bool = false
    @State private var replyToMessage: Message? = nil

    var body: some View {
        VStack(spacing: 0) {
//            Spacer()
            
            MessageList(messages: chatManager.messages, currentUserID: currentUserID, chat: chat, isReplying: $isReplying, replyToMessage: $replyToMessage)
//                .offset(y: 20)
               
            ChatInputArea(text: text, isReplying: $isReplying, replyToMessage: $replyToMessage)
           
        }
        .popup(isPresented: $isSurveysPresented) {
            SurveyView(surveyManager: surveyManager, chatID: chat.id)
        }
        .toolbar(isBottomTabBarHidden ? .hidden : .visible, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChatHeader(chat: chat, chatManager: chatManager, surveyManager: surveyManager ,isSurveysPresented: $isSurveysPresented)
            }
        }
        
        .onAppear {
            chatManager.loadMessages(withID: chat.id)
            chatManager.loadMembers(withID: chat.id)
            
            if !chat.isPrivate {
                surveyManager.loadSurveys(withID: chat.id)
            }
        }
    }
}

//#Preview {
//    SingleChat(chatManager: ChatManager())
//}
