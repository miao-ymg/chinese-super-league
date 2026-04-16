//
//  TeamStats.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
//

struct TeamStats: Decodable {
    let name: String
    let played: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let goalDifference: Int
    let points: Int

    // All JSON properties to decode
    enum CodingKeys: String, CodingKey {
        case name = "teamName"
        case played, wins, draws, losses, goalDifference, points
    }
}
