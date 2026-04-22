//
//  MatchesView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 22.04.26.
//

import SwiftUI

// (Mock Data)
private let club1 = Club(id: "SHANGHAI_SHENHUA", idApi: 210551171745140, nameShort: "Shanghai SH")
private let club2 = Club(id: "SHANGHAI_PORT", idApi: 233196699786207, nameShort: "Shanghai Port")
private let club3 = Club(id: "BEIJING", idApi: 243648644304690, nameShort: "Beijing Guoan")
private let club4 = Club(id: "CHENGDU", idApi: 347550392128893, nameShort: "Chengdu RC")


struct MatchesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                MatchCard(homeTeam: club1, awayTeam: club2, goals: (1, 0), matchStatus: "79'")
                MatchCard(homeTeam: club3, awayTeam: club4, goals: (1, 2), matchStatus: "90+5'")
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.dark1)
    }
}
