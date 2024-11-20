//
//  AsyncWebImage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct AsyncWebImage: View {
    private var url:            URL
    private var placeholder:    Image
    
    init(url: URL, placeholder: Image) {
        self.url            = url
        self.placeholder    = placeholder
    }
    
    var body: some View {
        placeholder
            .resizable()
            .onAppear {}
            .onDisappear {}
    }
}

//#Preview {
//    AsyncWebImage()
//}
