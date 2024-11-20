//
//  AsyncImageCache.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import Foundation
import SwiftUI

class AsyncImageCache {
    static let shared = AsyncImageCache()
    
    private var cache: NSCache = NSCache<NSString, UIImage>()
    
    subscript(key: String) -> UIImage? {
        get { cache.object(forKey: NSString(string: key)) }
        set(image) { image == nil ?
            self.cache.removeObject     (forKey: NSString(string: key)) :
            self.cache.setObject(image!, forKey: NSString(string: key))
        }
    }
}
