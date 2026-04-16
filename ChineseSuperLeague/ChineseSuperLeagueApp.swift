//
//  ChineseSuperLeagueApp.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.04.26.
//

import SwiftUI

@main
struct ChineseSuperLeagueApp: App {
    var body: some Scene {
        WindowGroup {
            StandingsView()
        }
        .modelContainer(clubContainer)
    }
}
