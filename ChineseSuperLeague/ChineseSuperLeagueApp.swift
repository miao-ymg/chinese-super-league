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
                // App-wide default font
                .font(.poppinsFont(14, weight: .regular))
                .task {
                    await vm.syncAndStore()
                }
        }
        .modelContainer(modelContainer)
    }
}
