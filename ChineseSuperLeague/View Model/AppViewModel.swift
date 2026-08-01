//
//  AppViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.07.26.
//

import Foundation
import os

@MainActor
class AppViewModel: ObservableObject {

    func syncAndStore() async {
        do {
            // Sync & store team data + logos
            if try DatabaseService.hasNoEntries(for: Team.self) {
                let teams: [TeamDTO] = try await NetworkClient.fetch(path: "/teams")
                Logger().debug("\(teams)")
                try DatabaseService.store(as: Team.self, dtos: teams)

                await NetworkClient.fetchImages(paths: teams.map { $0.logoUrl }, type: "logo")
            } else {
                Logger().info("Info: Teams have already been imported into the database")
            }
            // Load team logos from disk to buffer
            MemoryCache.bufferTeamLogos()

            // Sync & store standings
            let standings: [StandingDTO] = try await NetworkClient.fetch(path: "/standings/CSL")
            Logger().debug("\(standings)")
            try DatabaseService.store(as: Standing.self, dtos: standings)

            // Sync & store all matches
            let matches: [MatchDTO] = try await NetworkClient.fetch(path: "/matches/competition/CSL")
            Logger().debug("\(matches)")
            try DatabaseService.store(as: Match.self, dtos: matches)

        } catch NetworkError.invalidURL {
            Logger().error("Invalid URL!")
        } catch NetworkError.invalidResponse {
            Logger().error("Invalid response!")
        } catch NetworkError.invalidData {
            Logger().error("Invalid data!")
        } catch {
            Logger().error("Request failed!")
        }
    }
}
