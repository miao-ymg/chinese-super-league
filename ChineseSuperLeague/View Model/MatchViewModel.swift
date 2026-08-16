//
//  MatchViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.08.26.
//

import Foundation

@MainActor
class MatchViewModel: ObservableObject {
    var match: Match
    var home: Team?
    var away: Team?

    var status: MatchStatus

    init(match: Match, home: Team?, away: Team?) {
        self.match = match
        self.home = home
        self.away = away
        self.status = MatchStatus(match.status)
    }

    func loadMatch() async {
        do {
            let matchDetails: MatchDetailsDTO = try await NetworkClient.fetch(path: "/matches/\(match.id)")
            dump(matchDetails)

            try DatabaseService.store(as: MatchDetails.self, dtos: [matchDetails])
            try DatabaseService.store(as: GoalEvent.self, dtos: matchDetails.events.filter { $0.eventType == "goal" }, foreignKey: match)
            try DatabaseService.store(as: CardEvent.self, dtos: matchDetails.events.filter { $0.eventType == "card" }, foreignKey: match)
            try DatabaseService.store(as: SubstitutionEvent.self, dtos: matchDetails.events.filter { $0.eventType == "sub" }, foreignKey: match)
            try DatabaseService.store(as: VideoAssistEvent.self, dtos: matchDetails.events.filter { $0.eventType == "var" }, foreignKey: match)
            try DatabaseService.store(as: MissEvent.self, dtos: matchDetails.events.filter { $0.eventType == "miss" }, foreignKey: match)

            try DatabaseService.deleteEvents()
        } catch {
            print(error)
        }
    }

    var primaryToolbarText: String {
        if status == .notStarted {
            return match.date.day
        } else if status == .live, let regular = match.timeRegular {
            return minuteOfPlay(regular: regular, added: match.timeAdded)
        } else {
            return status.fullString
        }
    }

    var secondaryToolbarText: String {
        if status == .notStarted &&
            !Calendar.current.isDateInToday(match.date) &&
            !Calendar.current.isDateInTomorrow(match.date) {
            return " • " + match.date.date
        } else {
            return ""
        }
    }
}
