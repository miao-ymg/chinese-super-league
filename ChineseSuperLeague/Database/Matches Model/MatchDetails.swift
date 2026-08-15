//
//  MatchDetails.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 14.08.26.
//

import SwiftData

@Model
class MatchDetails: PersistableModel {
    @Attribute(.unique) var id: Int

    var venueName: String?
    var venueLocation: String?
    var refereeName: String?
    var refereeNationality: String?
    var attendance: Int?

    required init(from dto: MatchDetailsDTO) {
        self.id = dto.matchId
        self.venueName = dto.context.venue.name
        self.venueLocation = dto.context.venue.location
        self.refereeName = dto.context.referee.name
        self.refereeNationality = dto.context.referee.nationality
        self.attendance = dto.context.attendance
    }
}
