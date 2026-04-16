//
//  Club.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
//

import SwiftData

@Model
class Club {
    var id: String
    var idApi: Int
    var nameShort: String

    init(id: String, idApi: Int, nameShort: String) {
        self.id = id
        self.idApi = idApi
        self.nameShort = nameShort
    }
}
