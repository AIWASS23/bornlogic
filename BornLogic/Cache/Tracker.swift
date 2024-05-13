//
//  Tracker.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

final class Tracker<T>: NSObject, NSCacheDelegate { 
    var keys = Set<String>()

    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        guard let entry = obj as? CacheEntry<T> else {
            return
        }

        keys.remove(entry.key)
    }
}
