//
//  MatchDTO.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 01.08.26.
//

import Foundation

struct MatchDTO: Decodable {
    let matchId: Int
    let matchday: Int
    let date: Date
    let status: String
    let timeElapsed: TimeElapsedDTO
    let teams: MatchTeamsDTO
    let score: HomeAwayValuesDTO
    let redCards: HomeAwayValuesDTO
}
