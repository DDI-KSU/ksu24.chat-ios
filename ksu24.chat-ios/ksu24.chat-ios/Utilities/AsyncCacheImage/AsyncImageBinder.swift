//
//  AsyncImageBinder.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI
import Combine

class AsyncImageBinder: ObservableObject {
    private var cancellable: AnyCancellable?
    
    @Published private(set) var image: UIImage?
    
    func load(url: URL) {
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

//#Preview {
//    AsyncImageBinder()
//}
