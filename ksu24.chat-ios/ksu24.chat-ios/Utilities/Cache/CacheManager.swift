//
//  CacheManager.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 16/12/2024.
//

import Foundation
import SwiftUI

struct CacheUsage: Hashable {
    var cacheType: String
    var size: Double
}

final class CacheManager {
    // MARK: - Shared Instance
    static let shared = CacheManager()

    // MARK: - Cache Instances
    private let fileCache = Cache<String, URL>()
    private let avatarCache = Cache<String, Data>()
    private let messageCache = Cache<String, String>() // Or use a `Message` struct
    
    private init() { }

    // MARK: - File Management
    func cacheFile(data: Data, forKey key: String) throws -> URL {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let destinationURL = cacheDirectory.appendingPathComponent(key)
        
        try data.write(to: destinationURL)
        fileCache.insert(destinationURL, forKey: key)
        return destinationURL
    }

    func file(for name: String) -> URL? {
        guard let cachedURL = fileCache.value(forKey: name) else { return nil }
        let fileManager = FileManager.default
        
        // Verify if the file exists at the cached path
        if fileManager.fileExists(atPath: cachedURL.path) {
            return cachedURL
        } else {
            // Remove invalid cache entry if the file does not exist
            fileCache.removeValue(forKey: name)
            return nil
        }
    }

    // MARK: - Avatar Management
    func cacheAvatar(data: Data, forKey key: String) {
        avatarCache.insert(data, forKey: key)
    }

    func avatar(forKey key: String) -> UIImage? {
        guard let data = avatarCache.value(forKey: key) else { return nil }
        return UIImage(data: data)
    }

    // MARK: - Message Management
    func cacheMessage(_ message: String, forKey key: String) {
        messageCache.insert(message, forKey: key)
    }

    func message(forKey key: String) -> String? {
        return messageCache.value(forKey: key)
    }

    // MARK: - Storage Usage
    func totalCacheSize() -> Int {
        let fileSize = fileCacheSize()
        let avatarSize = avatarCacheSize()
        let messageSize = messageCacheSize()
        return fileSize + avatarSize + messageSize
    }
    
    func cacheUsageByType() -> [CacheUsage] {
        return [
            CacheUsage(cacheType: "Files", size: Double(fileCacheSize())),
            CacheUsage(cacheType: "Avatars", size: Double(avatarCacheSize())),
            CacheUsage(cacheType: "Messages", size: Double(messageCacheSize()))
        ]
    }

    private func avatarCacheSize() -> Int {
            return avatarCache.allKeys.compactMap { key in
                avatarCache.value(forKey: key)?.count
            }.reduce(0, +)
        }
        
    private func fileCacheSize() -> Int {
        return fileCache.allKeys.compactMap { key in
            guard let url = fileCache.value(forKey: key) else { return 0 }
            let attributes = try? FileManager.default.attributesOfItem(atPath: url.path)
            return attributes?[.size] as? Int
        }.reduce(0, +)
    }
    
    private func messageCacheSize() -> Int {
        return messageCache.allKeys.compactMap { key in
            messageCache.value(forKey: key)?.utf8.count
        }.reduce(0, +)
    }
    
    // MARK: - Save and Load
    func saveToDisk() {
        try? fileCache.saveToDisk(withName: "fileCache")
        try? avatarCache.saveToDisk(withName: "avatarCache")
        try? messageCache.saveToDisk(withName: "messageCache")
    }
}

extension CacheManager {
    
   
    func downloadAndCacheFile(from url: URL, forKey key: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let uniqueFileName = "\(UUID().uuidString)_\(key)" // Add unique prefix
        let destinationURL = cacheDirectory.appendingPathComponent(uniqueFileName)

        if fileManager.fileExists(atPath: destinationURL.path) {
            fileCache.insert(destinationURL, forKey: key) // Ensure it's cached
            completion(.success(destinationURL))
            return
        }

        URLSession.shared.downloadTask(with: url) { tempLocalUrl, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let tempLocalUrl = tempLocalUrl else {
                completion(.failure(NSError(domain: "DownloadError", code: -1, userInfo: nil)))
                return
            }

            do {
                // Use a local reference to FileManager to ensure @Sendable compatibility
                let localFileManager = FileManager.default
                try localFileManager.moveItem(at: tempLocalUrl, to: destinationURL)
                self.fileCache.insert(destinationURL, forKey: key)
                completion(.success(destinationURL))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }\
}


