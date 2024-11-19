//
//  ChatManager.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import Foundation
import Combine

class ChatManager: ObservableObject {
    @Published public var chats: [Chat] = []
    
    private var NRL:            NetworkResponseLoader<Chat>
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.NRL = .init()
    }
}
