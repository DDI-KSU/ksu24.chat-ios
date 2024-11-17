//
//  Sender.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation

struct Sender: Codable, Identifiable, Hashable {
    var id:             UUID
    var fullName:       String
    var shortName:      String
    var image:          String?
    var lastActivity:   String
}
