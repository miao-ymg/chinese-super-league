//
//  StandingsViewModel.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 31.12.24.
//

import SwiftUI
import os

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
            Logger().info("ERROR: Invalid URL")
        } catch NetworkError.invalidData {
            Logger().info("ERROR: Invalid Data")
        } catch {
            Logger().info("ERROR: Unexpected error")
        }
    }
}
