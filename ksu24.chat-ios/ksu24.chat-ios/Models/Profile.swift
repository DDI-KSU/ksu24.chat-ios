//
//  Profile.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import Foundation

public struct Profile: Codable {
    public var id:      UUID
    public var name:    String
    public var surname: String
    public var image:   String?
}
