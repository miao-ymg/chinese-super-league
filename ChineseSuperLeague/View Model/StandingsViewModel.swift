//
//  StandingsViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
//

import Foundation
import os

@MainActor
class StandingsViewModel: ObservableObject {
    @Published var standingsData: [(standing: Standing, shortName: String?)] = []

    func loadStandings() {
        do {
            // Query all DB entities
            var standings = try DatabaseService.queryAll(for: Standing.self)
            let teams = try DatabaseService.queryAll(for: Team.self)

            // Sort standings by ascending table rank
            standings = standings.sorted { $0.rank < $1.rank }

            // Join standings with abbreviated team names
            standingsData = standings.map { standing in
                let team = teams.first { $0.id == standing.teamId }
                return (standing, team?.nameShort)
            }
        } catch {
            Logger().error("Failed loading standings!")
        }
    }
}
