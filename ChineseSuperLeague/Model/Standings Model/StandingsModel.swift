//
//  StandingsModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 29.12.24.
//

import SwiftUI

/**
 Fetch league standings from the API and decode them into `TeamStats` objects
 */
func fetchLeagueStandings() throws -> [TeamStats] {
    // Read data from JSON file
    guard let filePath = Bundle.main.url(forResource: "test", withExtension: "json") else {
        throw NetworkError.invalidURL
    }
    let data = try Data(contentsOf: filePath)

    // Deserialization
    if let dataModel = try JSONSerialization.jsonObject(with: data) as? [String: Any],
       // Navigate to target array within nested JSON
       let response = dataModel["response"] as? [[String: Any]],
       let league = response.first?["league"] as? [String: Any],
       let standings = (league["standings"] as? [[[String: Any]]])?.first {

        // Serialization
        let teamsData = try JSONSerialization.data(withJSONObject: standings)
        // Decoding step
        return try JSONDecoder().decode([TeamStats].self, from: teamsData)
    } else {
        throw NetworkError.invalidData
    }
}

func getNameFromClubAPIID(idApi: Int, clubs: [Club]) -> String? {
    return clubs.first { $0.idApi == idApi }?.nameShort
}
