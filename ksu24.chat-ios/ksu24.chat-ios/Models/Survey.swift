//
//  Survey.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 04/12/2024.
//
import Foundation

struct Survey: Codable, Identifiable {
    var id:             UUID
    var content:        String
    var start:          String
    var end:            String
    var is_anonymous:   Bool?
    var questions:      [Question]
}

struct Question: Codable, Identifiable, Hashable {
    var id:         UUID = UUID()
    var content:    String = ""
    var answers:    [Answer] = []
}

struct Answer: Codable, Identifiable, Hashable {
    var id:         UUID = UUID()
    var content:    String = ""
}

struct CreatedSurvey: Codable {
    var content:        String
    var start:          String
    var end:            String
    var is_anonymous:   Bool?
    var questions:      [Question]
}
