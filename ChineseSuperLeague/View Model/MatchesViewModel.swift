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

struct DateGroup: Identifiable {
    let date: Date?
    let matches: [MatchData]

    var id: Date? { date }
}

struct MatchdayGroup: Identifiable {
    let matchday: Int
    let dates: [DateGroup]

    var id: Int { matchday }
}


@MainActor
class MatchesViewModel: ObservableObject {
    @Published var groupedMatches: [MatchdayGroup] = []
    private var matchesData: [MatchData] = []

    func loadAllMatches() {
        do {
            let matches = try DatabaseService.queryAll(for: Match.self)
            let teams = try DatabaseService.queryAll(for: Team.self)

            let teamLookup = Dictionary(uniqueKeysWithValues: teams.map { ($0.id, $0) })

            matchesData = matches.map { match in
                MatchData(
                    match: match,
                    home: teamLookup[match.homeTeamId],
                    away: teamLookup[match.awayTeamId]
                )
            }

            groupedMatches = groupMatches(matches: matchesData)
        } catch {
            Logger().error("Failed loading all matches!")
        }
    }

    /// Group match data by matchday, then by date (matches without date sort last)
    private func groupMatches(matches: [MatchData]) -> [MatchdayGroup] {
        // Level 1: Bucketing by matchday
        let byMatchday = Dictionary(grouping: matches) { $0.match.matchday }

        return byMatchday.map { matchday, matches in
            // Level 2: Bucketing by date only
            let byDate = Dictionary(grouping: matches) { $0.match.date?.withoutTime }

            let dateGroups = byDate.map { date, matches in
                // Level 3: Sorting by date & time
                let sortedMatches = matches.sorted {
                    ($0.match.date ?? .distantFuture) < ($1.match.date ?? .distantFuture)
                }

                return DateGroup(date: date, matches: sortedMatches)
            }
            .sorted { ($0.date ?? .distantFuture) < ($1.date ?? .distantFuture) }

            return MatchdayGroup(matchday: matchday, dates: dateGroups)
        }
        .sorted { $0.matchday < $1.matchday }
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
