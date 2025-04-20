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
    private var cache = CacheManager.shared
    
    @Published private(set) var image: UIImage?
    
    func load(url: URL) {
        if let image: UIImage = cache.avatar(forKey: url.absoluteString) {
            self.image = image
            return
        }

        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { output in
                // Cache the raw image data here
                self.cache.cacheAvatar(data: output.data, forKey: url.absoluteString)
            })
            .map { UIImage(data: $0.data) } // Convert the raw data to UIImage
            .replaceError(with: nil) // Handle any errors gracefully
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
