//
//  NetworkResponse.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation

// TODO: Reconsider response handling (model is included)
struct NetworkResponse<Wrapped: Codable>: Codable {
    var count:      Int
    var next:       String?
    var preivous:   String?
    var results:    [Wrapped]
}
