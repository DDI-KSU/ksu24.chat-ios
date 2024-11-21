//
//  AvatarHelpers.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 21/11/2024.
//

import Foundation
import SwiftUI

enum AvatarPlaceHolderColor: CaseIterable {
    case PURPLE
    case GREEN
    case BLUE
    case ORANGE
    case PINK
    
    var color: Color {
        switch self {
        case .PURPLE:
            return Color.purple
        case .GREEN:
            return Color.green
        case .BLUE:
            return Color.blue
        case .ORANGE:
            return Color.orange
        case .PINK:
            return Color.pink
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

