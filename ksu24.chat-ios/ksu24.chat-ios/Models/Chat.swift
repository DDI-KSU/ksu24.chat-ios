//
//  Chat.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation

struct Chat: Codable, Identifiable, Hashable {
    var id:                         UUID
    var name:                       String
    var description:                String?
    var isChannel:                  Bool
    var isPrivate:                  Bool
    var image:                      String?
    var lastMessage:                LastMessage?
    var messagesSinceLastChecked:   Int?
    var conversationType:           Int
}

struct LastMessage: Codable, Identifiable, Hashable {
    var id:             UUID
    var sender:         Member?
    var content:        String
    var created:        String
    var attachments:    [String] = []
}
