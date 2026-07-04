//
//  PersistableModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.07.26.
//

import SwiftData

/// Protocol enabling SwiftData models to be built generically from DTOs
protocol PersistableModel: PersistentModel {
    // The associated DTO type for each model (e.g. Team -> TeamDTO)
    associatedtype DTO: Decodable
    // Required for each model
    init(from dto: DTO)
}
