//
//  ChineseSuperLeagueApp.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.04.26.
//

import SwiftUI

@main
struct ChineseSuperLeagueApp: App {
    @StateObject private var vm = AppViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await vm.fetchTeams()
                }
        }
        .modelContainer(teamsContainer)
    }
}
