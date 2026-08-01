//
//  MatchesViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 01.08.26.
//

import Foundation
import os


struct MatchData {
    let match: Match
    let home: Team?
    let away: Team?
}


@MainActor
class MatchesViewModel: ObservableObject {
    @Published var matchesData: [MatchData] = []

    func loadAllMatches() {
        do {
            var matches = try DatabaseService.queryAll(for: Match.self)
            let teams = try DatabaseService.queryAll(for: Team.self)

            // Sort matches by matchday, then by date (matches without date sort last)
            matches = matches.sorted {
                ($0.matchday, $0.date ?? .distantFuture) < ($1.matchday, $1.date ?? .distantFuture)
            }

            let teamLookup = Dictionary(uniqueKeysWithValues: teams.map { ($0.id, $0) })

            matchesData = matches.map { match in
                MatchData(
                    match: match,
                    home: teamLookup[match.homeTeamId],
                    away: teamLookup[match.awayTeamId]
                )
            }
        } catch {
            Logger().error("Failed loading all matches!")
        }
    }

    func statusText(_ status: MatchStatus, timeElapsed: (Int?, Int?)) -> String {
        // Ongoing match? -> Return elapsed time
        if status == .live, let regular = timeElapsed.0 {
            let added = timeElapsed.1.map { "+\($0)" } ?? ""
            return "\(regular)\(added)'"
        } else {
            return status.rawValue
        }
    }
}
