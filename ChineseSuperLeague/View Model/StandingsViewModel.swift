//
//  StandingsViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 31.12.24.
//

import SwiftUI

@Observable class StandingsViewModel {
    var teamList: [TeamStats]?  // Optional, because `teamList doesn't exist yet before function call
    let triviaItems = [
        ("AFC Champions League Elite", Color.aclElite),
        ("AFC Champions League Elite play-off", Color.aclPlayoff),
        ("AFC Champions League Two", Color.aclTwo),
        ("Relegation", Color.relegation)
    ]

    func getLeagueStandings() {
        do {
            teamList = try fetchLeagueStandings()
        } catch NetworkError.invalidURL {
            print("ERROR: Invalid URL")
        } catch NetworkError.invalidData {
            print("ERROR: Invalid Data")
        } catch {
            print("ERROR: Unexpected error")
        }
    }
}
