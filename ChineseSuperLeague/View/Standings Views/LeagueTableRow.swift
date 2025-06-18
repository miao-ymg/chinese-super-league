//
//  LeagueTableRow.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 31.12.24.
//

import SwiftUI

struct LeagueTableRow: View {
    let team: Team          // Locally stored team profile
    let stats: TeamStats    // Team stats fetched from the API

    var body: some View {
        let logoSize: CGFloat = 0.7 * tableRowHeight

        ZStack {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                // Outcome indicator
                Rectangle()
                    .foregroundColor(StandingsViewModel.colorByRank(leaguePosition: stats.rank))
                    .frame(width: 6)
                    .cornerRadius(1)
                    .padding(2)
                // League position
                Text("\(stats.rank)")
                    .fontWeight(.semibold)
                    .horizPosItem(index: 0, totalWidth: screenWidth)
                // Team
                HStack {
                    // Crest
                    Image("crest-small-\(team.id)")
                        .resizable()
                        .frame(width: logoSize, height: logoSize)
                    Text("\(team.nameShort)")
                        .font(.poppinsFont(fontSize - 1, weight: .regular))
                }
                .frame(width: 0.4 * screenWidth, alignment: .leading)
                .horizPosItem(index: 1, totalWidth: screenWidth)

                // Statistics
                Text("\(stats.played)")
                    .horizPosItem(index: 2, totalWidth: screenWidth)
                Text("\(stats.wins)")
                    .horizPosItem(index: 3, totalWidth: screenWidth)
                Text("\(stats.draws)")
                    .horizPosItem(index: 4, totalWidth: screenWidth)
                Text("\(stats.losses)")
                    .horizPosItem(index: 5, totalWidth: screenWidth)
                Text("\(stats.goalDifference > 0 ? "+" : "")\(stats.goalDifference)")
                    .horizPosItem(index: 6, totalWidth: screenWidth)
                Text("\(stats.points)")
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.semibold)
                    .horizPosItem(index: 7, totalWidth: screenWidth)
            }
        }
        .frame(height: tableRowHeight)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}
