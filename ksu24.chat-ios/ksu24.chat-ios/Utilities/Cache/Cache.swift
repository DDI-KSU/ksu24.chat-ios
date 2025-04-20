import Foundation

final class Cache<Key: Hashable, Value> {
    // MARK: - Properties
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()
    
    // MARK: - Initializer
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 12 * 60 * 60,
         maximumEntryCount: Int = 50) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        
        wrapped.countLimit = maximumEntryCount
        wrapped.delegate = keyTracker
    }
    
    // MARK: - Insert Value
    func insert(_ value: Value, forKey key: Key) {
        let expirationDate = dateProvider().addingTimeInterval(entryLifetime)
        let size = calculateSize(of: value)
        let entry = Entry(key: key, value: value, expirationDate: expirationDate, size: size)
        
        wrapped.setObject(entry, forKey: WrappedKey(key))
        keyTracker.keys.insert(key)
    }
    
    // MARK: - Fetch Value
    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        return entry.value
    }
    
    // MARK: - Remove Value
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    
    // MARK: - Total Size
    func totalCacheSize() -> Int {
        return keyTracker.keys.compactMap { key in
            entry(forKey: key)?.size
        }.reduce(0, +)
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key
        init(_ key: Key) { self.key = key }
        
        override var hash: Int { return key.hashValue }
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date
        let size: Int
        
        init(key: Key, value: Value, expirationDate: Date, size: Int) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
            self.size = size
        }
    }
}

private extension Cache {
    func entry(forKey key: Key) -> Entry? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }

        return entry
    }
}

private extension Cache {
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()

        func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject object: Any) {
            guard let entry = object as? Entry else { return }
            keys.remove(entry.key)
        }
    }
}

// MARK: - Size Calculation
private extension Cache {
    func calculateSize(of value: Value) -> Int {
        if let data = value as? Data {
            return data.count
        } else if let string = value as? String {
            return string.utf8.count
        } else if let url = value as? URL {
            let attributes = try? FileManager.default.attributesOfItem(atPath: url.path)
            return attributes?[.size] as? Int ?? 0
        } else {
            return MemoryLayout.size(ofValue: value)
        }
    }
}

// MARK: - Codable Persistence
extension Cache.Entry: Codable where Key: Codable, Value: Codable {}

extension Cache: Codable where Key: Codable, Value: Codable {
    convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach { entry in
            self.insert(entry.value, forKey: entry.key)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let entries = keyTracker.keys.compactMap { entry(forKey: $0) }
        try container.encode(entries)
    }
}
extension Cache where Key: Codable, Value: Codable {
    func saveToDisk(withName name: String, using fileManager: FileManager = .default) throws {
        let folderURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = folderURL.appendingPathComponent("\(name).cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}

extension Cache {
    // Expose the cached keys in a read-only way
    var allKeys: [Key] {
        return Array(keyTracker.keys)
    }
}
