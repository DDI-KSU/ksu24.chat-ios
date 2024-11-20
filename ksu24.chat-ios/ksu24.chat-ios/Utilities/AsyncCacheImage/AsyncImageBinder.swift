//
//  AsyncImageBinder.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI
import Combine

class AsyncImageBinder: ObservableObject {
    private var cancellables: AnyCancellable?
    
    @Published private(set) var image: UIImage?
    
    func load(url: URL) {
        
    }
    
    func cancel() {
        
    }
}

//#Preview {
//    AsyncImageBinder()
//}
