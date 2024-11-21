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

extension Message {
    func isFromCurrentUser(currentUserID id: UUID) -> Bool {
        print(id)
        
        return id == sender.id
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom { decoder in
        let container   = try decoder.singleValueContainer()
        let dateString  = try container.decode(String.self)
        let formatter   = ISO8601DateFormatter()
        
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
        }
        
        return date
    }
}

