//
//  User.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 18/11/2024.
//

import Foundation

struct Token: Codable {
    var access:     String
    var refresh:    String
}

extension Token: CustomStringConvertible {
    var description: String {
            "{ access: \(access), refresh: \(refresh) }"
    }
}
