//
//  FlipView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 09/12/2024.
//

import SwiftUI

// MARK: - FLIPPING ANIMAITON
struct FlipView<FrontView: View, BackView: View> : View {
    var front: FrontView
    var back: BackView
    
    @State private var flipped = false
    @Binding var showBack: Bool
    
    var body: some View {
        ZStack {
            front.opacity(flipped ? 0.0 : 1.0)
            back.opacity(flipped ? 1.0 : 0.0)
        }
        .modifier(FlipEffect(flipped: $flipped, angle: showBack ? 180 : 0, axis: (x: 0, y: 1)))
    }
}
