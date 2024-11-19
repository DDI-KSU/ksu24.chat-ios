//
//  ChatManager.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import Foundation
import Combine

class ChatManager: ObservableObject {
    @Published public var chats:    [Chat]    = []
    @Published public var messages: [Message] = []
    
    private var NRL:            NetworkResponseLoader
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.NRL = .init()
    }
    
    public func loadChats() {
        NRL.loadCollactable(modelType: Chat.self, endpoint: .conversations, method: "GET")
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Login failed: \(error)")
                    }
                },
                receiveValue: { result in
                    self.chats = result
                })
                .store(in: &cancellables)
    }
    
    public func loadMessages(withID: UUID) {
        NRL.loadCollactable(modelType: Message.self, endpoint: .messages(withID: withID), method: "GET")
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Login failed: \(error)")
                    }
                },
                receiveValue: { result in
                    self.messages = result
                })
                .store(in: &cancellables)
            
    }
}
