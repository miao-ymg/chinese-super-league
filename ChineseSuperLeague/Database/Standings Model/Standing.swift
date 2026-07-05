//
//  Standing.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 05.07.26.
//

import SwiftData

@Model
class Standing: PersistableModel {
    @Attribute(.unique) var teamId: Int

    var teamName: String
    var rank: Int
    var played: Int
    var wins: Int
    var draws: Int
    var losses: Int
    var goalsFor: Int
    var goalsAgainst: Int
    var goalDifference: Int
    var points: Int
    var form: String

    required init(from dto: StandingDTO) {
        self.teamId = dto.teamId
        self.teamName = dto.teamName
        self.rank = dto.rank
        self.played = dto.played
        self.wins = dto.wins
        self.draws = dto.draws
        self.losses = dto.losses
        self.goalsFor = dto.goalsFor
        self.goalsAgainst = dto.goalsAgainst
        self.goalDifference = dto.goalDifference
        self.points = dto.points
        self.form = dto.form
    }
}
