//
//  File.swift
//  BornLogic
//
//  Created by Marcelo De Araújo on 13/05/24.
//

import Foundation

actor File<T: Codable>: CacheType {
    var tracker: Tracker<T> = .init()
    let cache: NSCache<NSString, CacheEntry<T>> = .init()
    let expirationInterval: TimeInterval
    let fileName: String

    init(fileName: String, expirationInterval: TimeInterval) {

        self.fileName = fileName
        self.expirationInterval = expirationInterval
    }

    private var saveLocationURL: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(fileName).cache")
    }

    func saveToDisk() {
        let entries = tracker.keys.compactMap(entry)
        print(entries.count)

        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: saveLocationURL)
        } catch {
            print(error.localizedDescription)
            return
        }

        print("Saving succeded.")
    }

    func loadFromDisk() {
        print(fileName)

        do {
            let data = try Data(contentsOf: saveLocationURL)
            let entries = try JSONDecoder().decode([CacheEntry<T>].self, from: data)
            entries.forEach { insert($0) }
            print(entries.count > 0 ? String(entries.count) : "No")
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}
