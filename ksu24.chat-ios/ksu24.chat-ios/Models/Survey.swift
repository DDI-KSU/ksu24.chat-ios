//
//  Survey.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 04/12/2024.
//
import Foundation

struct Survey: Codable {
    var id:             UUID
    var content:        String
    var started:        String
    var end:            String
    var is_anonymous:   Bool
    var questions:      [Question]
}

struct Question: Codable {
    var id:         UUID
    var content:    String
    var answers:    [Answer]
}

struct Answer: Codable {
    var id:         UUID
    var content:    String
}
