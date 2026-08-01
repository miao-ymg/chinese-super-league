//
//  MatchDTO.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 01.08.26.
//

struct MatchDTO: Decodable {
    let matchId: Int
    let matchday: Int
    let date: String
    let status: String
    let timeElapsed: TimeElapsedDTO
    let teams: MatchTeamsDTO
    let score: HomeAwayValuesDTO
    let redCards: HomeAwayValuesDTO
}

struct TimeElapsedDTO: Decodable {
    let regular: Int?
    let added: Int?
}

struct MatchTeamsDTO: Decodable {
    let home: NamedEntityDTO
    let away: NamedEntityDTO
}

struct HomeAwayValuesDTO: Decodable {
    let home: Int?
    let away: Int?
}
