//
//  ChineseSuperLeagueApp.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 10.09.24.
//

import SwiftUI

@main
struct ChineseSuperLeagueApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(teamsContainer)
    }
}
