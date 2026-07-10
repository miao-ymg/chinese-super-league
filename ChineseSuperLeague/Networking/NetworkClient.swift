//
//  NetworkClient.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.07.26.
//

import Foundation
import os

enum NetworkClient {
    private static let baseURL = Bundle.main.object(forInfoDictionaryKey: "ServerBaseURL") as? String

    private static let decoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    /// Generic API fetching method for any DTO.
    static func fetch<T: Decodable>(path: String) async throws -> T {
        Logger().info("Fetching from '\(path)' endpoint ..")

        guard let baseURL,
              let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }

        // Perform API request
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }

        // Decode response data
        let envelope = try decoder.decode(ResponseEnvelope<T>.self, from: data)
        guard envelope.success else {
            throw NetworkError.invalidResponse
        }

        Logger().info("Successfully fetched from '\(path)' endpoint!")
        return envelope.data
    }

    /// Fetch images for the given file paths
    static func fetchImages(paths: [String], type: String) async {
        guard let baseURL else { return }

        await withTaskGroup(of: Void.self) { group in
            for path in paths {
                group.addTask {
                    // Perform API request
                    guard let url = URL(string: baseURL + path) else { return }
                    guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }

                    // Store persistently to disk
                    let fileName = "\(type)-\(url.lastPathComponent)"
                    DiskCache.save(data: data, fileName: fileName)
                }
            }
        }
    }
}
