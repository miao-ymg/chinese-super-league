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
let legendFontSize: CGFloat = 11
let tableRowHeight: CGFloat = 44
let triviaItemHeight: CGFloat = 20
// Default percentual horizontal positions for table items
let percentualPositions = [0.06, 0.3, 0.54, 0.62, 0.7, 0.78, 0.86, 0.95]
let triviaItems = [
    ("AFC Champions League Elite", Color.aclElite),
//    ("AFC Champions League Elite play-off", Color.aclPlayoff),
    ("AFC Champions League Two", Color.aclTwo),
    ("Relegation", Color.relegation)
]

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
        .font(.poppinsFont(legendFontSize, weight: .regular))
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
                    let teamsWithStats = StandingsViewModel.joinTeamsWithStandings(teams: teams, standings: viewModel.standings)
                    ForEach(teamsWithStats, id: \.0) { team, stats in
                        LeagueTableRow(team: team, stats: stats)
                    }
                }
                VStack {
                    // Trivia
                    ForEach(triviaItems, id: \.0) { item in
                        TriviaItem(leagueOutcome: item.0, circleColor: item.1)
                    }
                    // Notes
                    Group {
                        Text("* One additional AFC Champions League Elite play-off slot allocated to the Chinese FA Cup winner")
                        Text("* Last updated on <DATE>")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.secondary)
                    .font(.poppinsFont(legendFontSize, weight: .regular))
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
