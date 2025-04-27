//
//  MatchesView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 23.04.25.
//

import SwiftUI

// (Mock Data)
private let club1 = Club(id: "CHANGCHUN", idApi: 834, nameShort: "Changchun YT")
private let club2 = Club(id: "SHANDONG", idApi: 844, nameShort: "Shandong TS")
private let club3 = Club(id: "SHANGHAI_PORT", idApi: 836, nameShort: "Shanghai Port")
private let club4 = Club(id: "SHANGHAI_SHENHUA", idApi: 833, nameShort: "Shanghai SH")


struct MatchesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                MatchCard(homeTeam: club1, awayTeam: club2, goals: (1, 2), matchStatus: "79'")
                MatchCard(homeTeam: club3, awayTeam: club4, goals: (1, 1), matchStatus: "90+2'")
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.dark1)
    }
}
