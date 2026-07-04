//
//  DatabaseService.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.07.26.
//

import SwiftData
import os

@MainActor
enum DatabaseService {
    private static let context = modelContainer.mainContext

    /// Generic SwiftData storage method for any model type
    static func store<M: PersistableModel>(as type: M.Type, dtos: [M.DTO]) throws {
        let modelType = String(describing: M.self)
        Logger().info("Storing '\(modelType)' entities in DB ..")

        for dto in dtos {
            let entity = M(from: dto)
            context.insert(entity)
        }
        try context.save()
        Logger().info("Successfully stored '\(modelType)' entities!")
    }

    /// Checks whether the store contains any entities of the given model type
    static func hasNoEntries<M: PersistentModel>(for type: M.Type) throws -> Bool {
        var descriptor = FetchDescriptor<M>()
        descriptor.fetchLimit = 1
        return try context.fetch(descriptor).isEmpty
    }
}
