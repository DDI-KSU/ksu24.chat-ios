//
//  ChatBubble.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI

struct ChatBubble: Shape {
//    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [
                .topLeft,
                .topRight,
                .bottomLeft
            ],
            cornerRadii: CGSize(width: 16, height: 16)
        )
        
        return Path(path.cgPath)
    }
}
