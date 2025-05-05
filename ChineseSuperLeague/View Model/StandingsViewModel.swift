//
//  StandingsViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 31.12.24.
//

import SwiftUI
import os

@Observable class StandingsViewModel {
    var standings: [TeamStats]?  // Optional, because `teamList doesn't exist yet before function call

    func getLeagueStandings() {
        do {
            standings = try fetchLeagueStandings()
        } catch NetworkError.invalidURL {
            Logger().info("ERROR: Invalid URL")
        } catch NetworkError.invalidData {
            Logger().info("ERROR: Invalid Data")
        } catch {
            Logger().info("ERROR: Unexpected error")
        }
    }

    /**
     Join internal team data with standings data fetched from the API
     */
    static func joinTeamsWithStandings(teams: [Team], standings: [TeamStats]?) -> [(Team, TeamStats)] {
        guard let standings = standings else { return [] }

        let join: [(Team, TeamStats)]
        join = teams.compactMap { team in
            guard let stats = standings.first(where: { $0.idApi == team.idApi }) else { return nil }
            return (team, stats)
        }

        // Sort by ascending table rank
        return join.sorted { $0.1.rank < $1.1.rank }
    }

    /**
     Map a league position to a color indicator in the standings view
     */
    static func colorByRank(leaguePosition: Int) -> Color {
        switch leaguePosition {
        case 1:
            return Color.aclElite
//        case 2:
//            return Color.aclPlayoff
        case 2:
            return Color.aclTwo
        case 15, 16:
            return Color.relegation
        default:
            return Color.clear
        }
    }
}
