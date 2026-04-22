//
//  MatchesView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 22.04.26.
//

import SwiftUI

// (Mock Data)
private let team1 = Team(id: "SHANGHAI_SHENHUA", idApi: 210551171745140, nameShort: "Shanghai SH")
private let team2 = Team(id: "SHANGHAI_PORT", idApi: 233196699786207, nameShort: "Shanghai Port")
private let team3 = Team(id: "BEIJING", idApi: 243648644304690, nameShort: "Beijing Guoan")
private let team4 = Team(id: "CHENGDU", idApi: 347550392128893, nameShort: "Chengdu RC")


struct MatchesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                MatchCard(homeTeam: team1, awayTeam: team2, goals: (1, 0), matchStatus: "79'")
                MatchCard(homeTeam: team3, awayTeam: team4, goals: (1, 2), matchStatus: "90+5'")
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.dark1)
    }
}
