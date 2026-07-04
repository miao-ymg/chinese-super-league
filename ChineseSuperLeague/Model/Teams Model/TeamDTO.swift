//
//  TeamDTO.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.07.26.
//

struct TeamDTO: Decodable {
    let teamId: Int
    let name: TeamNameDTO
    let logoUrl: String
    let country: String
    let teamColor: String
}

struct TeamNameDTO: Decodable {
    let full: String
    let short: String
}
