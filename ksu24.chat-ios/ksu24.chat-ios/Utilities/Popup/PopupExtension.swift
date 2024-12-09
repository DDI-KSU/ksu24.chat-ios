//
//  PopupExtension.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 04/12/2024.
//

import Foundation
import SwiftUI

public struct Popup<PopupContent>: ViewModifier where PopupContent: View {
    init(isPresented: Binding<Bool>,
            view: @escaping () -> PopupContent) {
           self._isPresented = isPresented
           self.view = view
       }

       /// Controls if the sheet should be presented or not
       @Binding var isPresented: Bool

       /// The content to present
       var view: () -> PopupContent
    
    // MARK: - Private Properties
    @State private var presenterContentRect: CGRect = .zero
    
    @State private var sheetContentRect: CGRect = .zero
    
    private var displayedOffset: CGFloat {
        -presenterContentRect.midY + screenHeight / 2
    }
    
    private var hiddenOffset: CGFloat {
        if presenterContentRect.isEmpty {
            return 1000
        }
        
        return screenHeight - presenterContentRect.midY + sheetContentRect.height / 2
    }
    
    private var currentOffset: CGFloat {
        return isPresented ? displayedOffset : hiddenOffset
    }
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    // MARK: - Content Builders
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .frameGetter($presenterContentRect)
        }
        .overlay(sheet())
    }
    
    func sheet() -> some View {
        ZStack {
            self.view()
//                .simultaneousGesture(
//                    TapGesture().onEnded {
//                        dismiss()
//                    })
                .frameGetter($sheetContentRect)
                .frame(width: screenWidth)
                .offset(x: 0, y: currentOffset)
                .animation(Animation.easeOut(duration: 0.3), value: currentOffset)
        }
    }
    
    private func dismiss() {
        isPresented = false
    }
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}


extension View {

    public func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        view: @escaping () -> PopupContent) -> some View {
        self.modifier(
            Popup(
                isPresented: isPresented,
                view: view)
        )
    }
}
