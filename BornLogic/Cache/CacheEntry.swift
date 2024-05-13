//
//  CacheEntry.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

final class CacheEntry<T> {

    let key: String
    let value: T
    let expiredTimestamp: Date

    init(key: String, value: T, expiredTimestamp: Date) {
        self.key = key
        self.value = value
        self.expiredTimestamp = expiredTimestamp
    }

    func isCacheExpired(after date: Date) -> Bool {
        date > expiredTimestamp
    }
}

extension CacheEntry: Codable where T: Codable {}
