//
//  PersistableModelWithFK.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.08.26.
//

import SwiftData

/// `PersistableModel` with foreign keys
protocol PersistableModelWithFK: PersistentModel {
    associatedtype DTO: Decodable
    associatedtype FK: PersistentModel
    init(from dto: DTO, foreignKey: FK)
}
