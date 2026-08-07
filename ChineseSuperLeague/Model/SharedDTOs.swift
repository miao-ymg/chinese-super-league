//
//  SharedDTOs.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 01.08.26.
//

struct HomeAwayValuesDTO: Decodable {
    let home: Int?
    let away: Int?
}

struct MatchTeamsDTO: Decodable {
    let home: NamedEntityDTO
    let away: NamedEntityDTO
}

struct NamedEntityDTO: Decodable {
    let id: Int
    let name: String
}

struct TimeElapsedDTO: Decodable {
    let regular: Int?
    let added: Int?
}
