//
//  MatchEvent.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 14.08.26.
//

import SwiftData
import Foundation

@Model
class MatchEvent: PersistableModelWithFK {
    @Attribute(.unique) var id: UUID
    var match: Match

    var seqNumber: Int
    var timeRegular: Int
    var timeAdded: Int?
    var type: String
    var team: String

    required init(from dto: MatchEventDTO, foreignKey: Match) {
        self.id = UUID()
        self.match = foreignKey
        self.seqNumber = dto.seqNumber
        self.timeRegular = dto.timeElapsed.regular
        self.timeAdded = dto.timeElapsed.added
        self.type = dto.eventType
        self.team = dto.team
    }
}

// --- Event type models ---

@available(iOS 26, *)
@Model
class GoalEvent: MatchEvent {
    var goalType: String
    var goalscorerId: Int
    var goalscorerName: String
    var assistId: Int?
    var assistName: String?
    var newScoreHome: Int?
    var newScoreAway: Int?

    required init(from dto: MatchEventDTO, foreignKey: Match) {
        guard case .goal(let goalDto) = dto.eventTypeData else { fatalError() }

        self.goalType = goalDto.goalType
        self.goalscorerId = goalDto.goalscorer.id
        self.goalscorerName = goalDto.goalscorer.name
        self.assistId = goalDto.assist?.id
        self.assistName = goalDto.assist?.name
        self.newScoreHome = goalDto.newScore.home
        self.newScoreAway = goalDto.newScore.away
        super.init(from: dto, foreignKey: foreignKey)
    }
}


@available(iOS 26, *)
@Model
class CardEvent: MatchEvent {
    var cardType: String
    var playerId: Int
    var playerName: String
    var missesNextMatch: Bool

    required init(from dto: MatchEventDTO, foreignKey: Match) {
        guard case .card(let cardDto) = dto.eventTypeData else { fatalError() }

        self.cardType = cardDto.cardType
        self.playerId = cardDto.player.id
        self.playerName = cardDto.player.name
        self.missesNextMatch = cardDto.missesNextMatch
        super.init(from: dto, foreignKey: foreignKey)
    }
}


@available(iOS 26, *)
@Model
class SubstitutionEvent: MatchEvent {
    var playerInId: Int
    var playerInName: String
    var playerOutId: Int
    var playerOutName: String
    var reason: String?

    required init(from dto: MatchEventDTO, foreignKey: Match) {
        guard case .sub(let subDto) = dto.eventTypeData else { fatalError() }

        self.playerInId = subDto.playerIn.id
        self.playerInName = subDto.playerIn.name
        self.playerOutId = subDto.playerOut.id
        self.playerOutName = subDto.playerOut.name
        self.reason = subDto.reason
        super.init(from: dto, foreignKey: foreignKey)
    }
}


@available(iOS 26, *)
@Model
class VideoAssistEvent: MatchEvent {
    var decision: String
    var reason: String?

    required init(from dto: MatchEventDTO, foreignKey: Match) {
        guard case .video(let videoDto) = dto.eventTypeData else { fatalError() }

        self.decision = videoDto.decision
        self.reason = videoDto.reason
        super.init(from: dto, foreignKey: foreignKey)
    }
}


@available(iOS 26, *)
@Model
class MissEvent: MatchEvent {
    var missType: String
    var playerId: Int
    var playerName: String

    required init(from dto: MatchEventDTO, foreignKey: Match) {
        guard case .miss(let missDto) = dto.eventTypeData else { fatalError() }

        self.missType = missDto.missType
        self.playerId = missDto.player.id
        self.playerName = missDto.player.name
        super.init(from: dto, foreignKey: foreignKey)
    }
}
