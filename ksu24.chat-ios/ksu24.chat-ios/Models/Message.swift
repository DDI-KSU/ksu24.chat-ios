//
//  Message.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation

struct Message: Codable, Identifiable {
    var id:             UUID
    var sender:         Member
    var replyTo:        Reply?
    var content:        String
    var created:        String
    var attachments:    [File]      = []
    var reactions:      [Reaction]  = []
}

struct Reply: Codable, Identifiable {
    var id:             UUID
    var sender:         Member
    var content:        String
    var created:        String
    var attachments:    [File] = []
}

struct Reaction: Codable {
    var person:     Member
    var reaction:   String
    var created:    String
}

struct File: Codable {
    var file:               String
    var originalFilename:   String
    var fileSize:           Int
}

