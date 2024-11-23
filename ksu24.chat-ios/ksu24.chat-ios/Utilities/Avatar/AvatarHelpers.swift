//
//  AvatarHelpers.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 21/11/2024.
//

import Foundation
import SwiftUI

enum AvatarPlaceHolderColor: CaseIterable {
    case DARKRED
    case GREEN
    case BLUE
    case YELLOW
    case PINK
    
    var color: Color {
        switch self {
        case .DARKRED:
            return Color(red: 238 / 255, green: 99 / 255, blue: 82 / 255)
        case .GREEN:
            return Color(red: 89 / 255, green: 205 / 255, blue: 144 / 255)
        case .BLUE:
            return Color(red: 63 / 255, green: 167 / 255, blue: 214 / 255)
        case .YELLOW:
            return Color(red: 250 / 255, green: 192 / 255, blue: 94 / 255)
        case .PINK:
            return Color(red: 247 / 255, green: 157 / 255, blue: 132 / 255)
        }
    }
}

extension Color {
    static func random() -> Color {
        AvatarPlaceHolderColor.allCases.randomElement()!.color
    }
}

extension String {
    func takeLettersForAvatar() -> String {
        
        let words = self.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        
        let initials = words.compactMap { $0.first }.map { String($0) }
        
        let firstTwoInitials = initials.prefix(2).joined()
        
        return firstTwoInitials.uppercased()
    }
}

