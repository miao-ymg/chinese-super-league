//
//  MemoryCache.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 10.07.26.
//

import UIKit

/// Level 1: Fast in-memory image cache
@MainActor  // Prevent data-races
class MemoryCache {

    private static let miniSize = 64

    // --- All image buffers given here ---
    private static var teamLogos: [Int: UIImage] = [:]
    private static var teamLogosMini: [Int: UIImage] = [:]


    /// Loads images from disk into a buffer, optionally filter by ID
    private static func bufferImages(type: String, ids: [Int]? = nil) -> [Int: UIImage] {
        var buffer: [Int: UIImage] = [:]

        // Only buffer the ids subset if requested
        if let ids {
            for id in ids {
                let fileName = "\(type)-\(id).png"
                if let image = DiskCache.load(fileName: fileName) {
                    buffer[id] = image
                }
            }
            return buffer
        }

        // Scan entire directory for requested image type
        guard let fileURLs = try? FileManager.default.contentsOfDirectory(
            at: DiskCache.dir,
            includingPropertiesForKeys: nil
        ) else {
            return buffer
        }
        let fileNames = fileURLs
            .filter { $0.lastPathComponent.hasPrefix(type) }
            .map { $0.lastPathComponent }

        for name in fileNames {
            guard let id = Int(name.dropFirst(type.count + 1).dropLast(4)) else { continue }
            if let image = DiskCache.load(fileName: name) {
                buffer[id] = image
            }
        }
        return buffer
    }

    /// Resize all images from a given buffer to a specified size (w, h)
    private static func resize(_ source: [Int: UIImage], to size: (width: Int, height: Int)) -> [Int: UIImage] {
        let size = CGSize(width: size.width, height: size.height)
        let renderer = UIGraphicsImageRenderer(size: size)

        var result: [Int: UIImage] = [:]
        for (id, image) in source {
            result[id] = renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: size))
            }
        }
        return result
    }

    /// Load an image with given ID from a specified buffer
    private static func getImage(id: Int, from source: inout [Int: UIImage], type: String) -> UIImage? {
        // Image buffered in cache
        if let cachedImage = source[id] {
            return cachedImage
        }
        // Image not in cache -> Load from disk
        if let diskImage = DiskCache.load(fileName: "\(type)-\(id).png") {
            source[id] = diskImage
            return diskImage
        }
        // No image existent for id
        return nil
    }


    // --- Public functions ---

    static func bufferTeamLogos() {
        teamLogos = bufferImages(type: "logo")
        teamLogosMini = resize(teamLogos, to: (miniSize, miniSize))
    }

    static func getMiniTeamLogo(id: Int) -> UIImage? {
        return getImage(id: id, from: &teamLogosMini, type: "logo")
    }
}
