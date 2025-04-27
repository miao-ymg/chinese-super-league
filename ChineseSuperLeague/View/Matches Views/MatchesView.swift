//
//  MatchesView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 23.04.25.
//

import SwiftUI

// (Mock Data)
private let team1 = Team(id: "CHANGCHUN", idApi: 834, nameShort: "Changchun YT")
private let team2 = Team(id: "SHANDONG", idApi: 844, nameShort: "Shandong TS")
private let team3 = Team(id: "SHANGHAI_PORT", idApi: 836, nameShort: "Shanghai Port")
private let team4 = Team(id: "SHANGHAI_SHENHUA", idApi: 833, nameShort: "Shanghai SH")


struct MatchesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                MatchCard(homeTeam: team1, awayTeam: team2, goals: (1, 2), matchStatus: "79'")
                MatchCard(homeTeam: team3, awayTeam: team4, goals: (1, 1), matchStatus: "90+2'")
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.dark1)
    }
}
