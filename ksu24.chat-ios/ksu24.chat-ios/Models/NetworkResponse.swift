//
//  NetworkResponse.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation

struct NetworkResponse<Wrapped: Codable>: Codable {
    var count:  Int
    var result: Wrapped
}
