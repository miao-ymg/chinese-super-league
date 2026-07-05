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
            // Sync & store standings
            let standings: [StandingDTO] = try await NetworkClient.fetch(path: "/standings/CSL")
            Logger().debug("\(standings)")
            try DatabaseService.store(as: Standing.self, dtos: standings)

            // Sync & store teams
            guard try DatabaseService.hasNoEntries(for: Team.self) else {
                Logger().info("Info: Teams have already been imported into the database")
                return
            }

            let teams: [TeamDTO] = try await NetworkClient.fetch(path: "/teams")
            Logger().debug("\(teams)")
            try DatabaseService.store(as: Team.self, dtos: teams)

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
