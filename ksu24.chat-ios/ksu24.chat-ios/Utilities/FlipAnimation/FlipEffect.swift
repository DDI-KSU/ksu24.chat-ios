//
//  FlipEffect.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 09/12/2024.
//

import Foundation
import SwiftUI

struct FlipEffect: GeometryEffect {
    var animatableData: Double {
        get { angle }
        set { angle = newValue}
    }
    
    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        
        let tweakAngle = flipped ? -180 + angle : angle
        let a = CGFloat(Angle(degrees: tweakAngle).radians)
        
        var transform3d = CATransform3DIdentity;
        
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width / 2.0, -size.height / 2.0, 0.0001)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
