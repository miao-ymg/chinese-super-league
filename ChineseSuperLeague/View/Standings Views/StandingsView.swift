//
//  StandingsView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 10.09.24.
//

import SwiftUI
import SwiftData

// ----- CONSTANTS -----

let fontSize: CGFloat = 13
let tableRowHeight: CGFloat = 44
let triviaItemHeight: CGFloat = 20
// Default percentual horizontal positions for table items
let percentualPositions = [0.06, 0.3, 0.54, 0.62, 0.7, 0.78, 0.86, 0.95]

// ----- VIEWS -----

struct TriviaItem: View {
    let leagueOutcome: String
    let circleColor: Color

    var body: some View {
        HStack {
            Circle()
                .foregroundColor(circleColor)
            Text(leagueOutcome)
        }
        .frame(height: triviaItemHeight)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .font(.poppinsFont(0.8 * fontSize, weight: .regular))
    }
}


struct StandingsView: View {
    @Query private var teams: [Team]

    @State private var viewModel = StandingsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // League table header
            LeagueTableHeader()

            ScrollView {
                // League standings
                VStack(spacing: 0) {
                    ForEach((viewModel.teamList ?? []).indices, id: \.self) { rank in
                        let apiTeam = viewModel.teamList![rank]
                        if let deviceTeam = getTeamFromAPIID(idApi: apiTeam.idApi, teams: teams) {
                            LeagueTableRow(leaguePosition: rank+1, apiTeam: apiTeam, deviceTeam: deviceTeam)
                        }
                    }
                }
                VStack {
                    // Trivia
                    ForEach(viewModel.triviaItems, id: \.0) { item in
                        TriviaItem(leagueOutcome: item.0, circleColor: item.1)
                    }
                    // Notes
                    Group {
                        Text("* One additional AFC Champions League Elite slot allocated to the Chinese FA Cup winner")
                        Text("* Last updated on <DATE>")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.poppinsFont(0.7 * fontSize, weight: .regular))
                }
                .padding(8)
            }
            .background(Color.dark1)
        }
        .font(.poppinsFont(fontSize, weight: .regular))

        .task {
            viewModel.getLeagueStandings()
        }
    }
}
