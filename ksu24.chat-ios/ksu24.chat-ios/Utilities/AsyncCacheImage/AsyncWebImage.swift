//
//  AsyncWebImage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct AsyncWebImage: View {
    @ObservedObject var binder = AsyncImageBinder()
    
    private var url:            URL
    private var placeholder:    AvatarPlaceHolder
    
    var size: CGFloat
    
    init(url: URL, placeholder: AvatarPlaceHolder, size: CGFloat) {
        self.url            = url
        self.placeholder    = placeholder
        self.size           = size
        
        self.binder.load(url: self.url)
    }
    
    var body: some View {
        VStack {
            if let image = binder.image {
                Image(uiImage: image)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                placeholder
            }
        }
        .onAppear {}
        .onDisappear {
            self.binder.cancel()
        }
    }
}

//#Preview {
//    AsyncWebImage()
//}
