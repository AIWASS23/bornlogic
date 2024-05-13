//
//  Cache.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

protocol Cache: Actor {
    associatedtype T
    var expirationInterval: TimeInterval { get }

    func setValue(_ value: T?, key: String)
    func value(key: String) -> T?
    func removeValue(key: String)
    func removeAllValues()
}

protocol CacheType: Cache {
    var cache: NSCache<NSString, CacheEntry<T>> { get }
    var tracker: Tracker<T> { get }
}

extension CacheType {
    func removeValue(key: String) {
        tracker.keys.remove(key)
        cache.removeObject(forKey: key as NSString)
    }

    func removeAllValues() {
        tracker.keys.removeAll()
        cache.removeAllObjects()
    }

    func setValue(_ value: T?, key: String) {
        if let value = value {
            let expiredTimestamp = Date().addingTimeInterval(expirationInterval)
            let cacheEntry = CacheEntry(key: key, value: value, expiredTimestamp: expiredTimestamp)
            insert(cacheEntry)
        } else {
            removeValue(key: key)
        }
    }

    func value(key: String) -> T? {
        entry(key: key)?.value
    }

    func entry(key: String) -> CacheEntry<T>? {
        guard let entry = cache.object(forKey: key as NSString) else {
            return nil
        }

        guard !entry.isCacheExpired(after: Date()) else {
            removeValue(key: key)
            return nil
        }

        return entry
    }

    func insert(_ entry: CacheEntry<T>) {
        tracker.keys.insert(entry.key)
        cache.setObject(entry, forKey: entry.key as NSString)
    }
}
