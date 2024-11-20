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
    private var cache = AsyncImageCache.shared
    
    @Published private(set) var image: UIImage?
    
    func load(url: URL) {
        if let image: UIImage = cache[url.absoluteString] {
            self.image = image
            return
        }

        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { self.cache[url.absoluteString] = $0 })
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
