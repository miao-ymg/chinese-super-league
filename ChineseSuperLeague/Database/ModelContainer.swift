//
//  ModelContainer.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
//

import SwiftData

/// Central SwiftData model container for the app
let modelContainer: ModelContainer = {

    // --- All @Model types given here ---
    let schema = Schema([
        Standing.self,
        Team.self
    ])

    do {
        return try ModelContainer(for: schema)
    } catch {
        fatalError("Failed to create container!")
    }
}()
