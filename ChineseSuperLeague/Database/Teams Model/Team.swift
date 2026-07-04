//
//  Team.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
//

import SwiftData

@Model
// Model conforms to custom protocol
class Team: PersistableModel {
    @Attribute(.unique) var id: Int

    var nameFull: String
    var nameShort: String
    var logoUrl: String
    var country: String
    var color: String

    // Initializer required by custom protocol
    required init(from dto: TeamDTO) {
        self.id = dto.teamId
        self.nameFull = dto.name.full
        self.nameShort = dto.name.short
        self.logoUrl = dto.logoUrl
        self.country = dto.country
        self.color = dto.teamColor
    }
}
