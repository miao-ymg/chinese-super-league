//
//  LeagueTableRow.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 31.12.24.
//

import SwiftUI

struct LeagueTableRow: View {
    let leaguePosition: Int
    let club: TeamStats
    let clubName: String

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                // Outcome indicator
                Rectangle()
                    .foregroundColor(colorByPosition(leaguePosition: leaguePosition))
                    .frame(width: 6)
                    .cornerRadius(1)
                    .padding(2)
                // League position
                Text("\(leaguePosition)")
                    .fontWeight(.semibold)
                    .horizPosItem(index: 0, totalWidth: screenWidth)
                // Club
                HStack {
                    // Crest
                    Circle()
                        .foregroundColor(.secondary)
                        .frame(height: 0.7 * tableRowHeight)
                        .aspectRatio(1, contentMode: .fit)
                    Text("\(clubName)")
                        .font(.poppinsFont(fontSize-1, weight: .regular))
                }
                .frame(width: 0.4 * screenWidth, alignment: .leading)
                .horizPosItem(index: 1, totalWidth: screenWidth)

                // Statistics
                Text("\(club.played)")
                    .horizPosItem(index: 2, totalWidth: screenWidth)
                Text("\(club.wins)")
                    .horizPosItem(index: 3, totalWidth: screenWidth)
                Text("\(club.draws)")
                    .horizPosItem(index: 4, totalWidth: screenWidth)
                Text("\(club.losses)")
                    .horizPosItem(index: 5, totalWidth: screenWidth)
                Text("\(club.goalDifference > 0 ? "+" : "")\(club.goalDifference)")
                    .horizPosItem(index: 6, totalWidth: screenWidth)
                Text("\(club.points)")
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.semibold)
                    .horizPosItem(index: 7, totalWidth: screenWidth)
            }
        }
        .frame(height: tableRowHeight)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

/**
 Map a league position to a color indicator in the league table view
 */
private func colorByPosition(leaguePosition: Int) -> Color {
    switch leaguePosition {
    case 1:
        return Color.aclElite
    case 2:
        return Color.aclPlayoff
    case 3:
        return Color.aclTwo
    case 15, 16:
        return Color.relegation
    default:
        return Color.clear
    }
}
