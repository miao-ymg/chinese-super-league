//
//  Team.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 03.01.25.
//

import SwiftData

@Model
class Team {
    var id: String
    var idApi: Int
    var nameShort: String

    init(id: String, idApi: Int, nameShort: String) {
        self.id = id
        self.idApi = idApi
        self.nameShort = nameShort
    }
}
