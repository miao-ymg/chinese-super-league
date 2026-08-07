//
//  MatchDetailsDTO.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 06.08.26.
//

struct MatchDetailsDTO: Decodable {
    let matchId: Int
    let matchday: Int
    let date: String
    let status: String
    let timeElapsed: TimeElapsedDTO
    let teams: MatchTeamsDTO
    let score: HomeAwayValuesDTO
    let context: MatchContextDTO
    // (Skipped `goalscorers`, `redCards`)
    let events: [MatchEventDTO]
}

struct MatchContextDTO: Decodable {
    let venue: VenueDTO
    let referee: RefereeDTO
    let attendance: Int?
}

struct VenueDTO: Decodable {
    let name: String?
    let location: String?
}

struct RefereeDTO: Decodable {
    let name: String?
    let nationality: String?
}
