//
//  Memory.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

actor Memory<T>: CacheType { // MemoryCache

    let cache: NSCache<NSString, CacheEntry<T>> = .init()
    var tracker: Tracker<T> = .init()
    let expirationInterval: TimeInterval

    init(expirationInterval: TimeInterval) {
        self.expirationInterval = expirationInterval
    }
}
