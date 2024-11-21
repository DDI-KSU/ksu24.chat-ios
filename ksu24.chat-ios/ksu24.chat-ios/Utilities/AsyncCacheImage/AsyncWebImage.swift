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
    
    init(url: URL, placeholder: AvatarPlaceHolder) {
        self.url            = url
        self.placeholder    = placeholder
        
        self.binder.load(url: self.url)
    }
    
    var body: some View {
        VStack {
            if let image = binder.image {
                Image(uiImage: image)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
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
