//
//  StandingDTO.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 05.07.26.
//

struct StandingDTO: Decodable {
    let teamId: Int
    let teamName: String
    let rank: Int
    let played: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let goalsFor: Int
    let goalsAgainst: Int
    let goalDifference: Int
    let points: Int
    let form: String
}
