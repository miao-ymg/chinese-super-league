//
//  DiskCache.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 10.07.26.
//

import UIKit

/// Level 2: Persistent file-based image cache
enum DiskCache {
    static let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]

    /// Writes an image to disk under given file name
    static func save(data: Data, fileName: String) {
        try? data.write(to: dir.appendingPathComponent(fileName))
    }

    /// Loads an image from disk by given file name
    static func load(fileName: String) -> UIImage? {
        guard let data = try? Data(contentsOf: dir.appendingPathComponent(fileName)) else { return nil }
        return UIImage(data: data)
    }
}
