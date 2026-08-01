//
//  Match.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 01.08.26.
//

import SwiftData
import Foundation

@Model
class Match: PersistableModel {
    @Attribute(.unique) var id: Int

    var matchday: Int
    var date: Date?
    var status: String
    var timeRegular: Int?
    var timeAdded: Int?
    var homeTeamId: Int
    var homeTeamName: String
    var awayTeamId: Int
    var awayTeamName: String
    var scoreHome: Int?
    var scoreAway: Int?
    var redCardsHome: Int?
    var redCardsAway: Int?

    required init(from dto: MatchDTO) {
        self.id = dto.matchId
        self.matchday = dto.matchday
        self.date = Date(from: dto.date)
        self.status = dto.status
        self.timeRegular = dto.timeElapsed.regular
        self.timeAdded = dto.timeElapsed.added
        self.homeTeamId = dto.teams.home.id
        self.homeTeamName = dto.teams.home.name
        self.awayTeamId = dto.teams.away.id
        self.awayTeamName = dto.teams.away.name
        self.scoreHome = dto.score.home
        self.scoreAway = dto.score.away
        self.redCardsHome = dto.redCards.home
        self.redCardsAway = dto.redCards.away
    }
}
