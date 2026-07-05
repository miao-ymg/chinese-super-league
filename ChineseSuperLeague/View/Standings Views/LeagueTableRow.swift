//
//  LeagueTableRow.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 16.04.26.
//

import SwiftUI

struct LeagueTableRow: View {
    let standingData: (standing: Standing, shortName: String?)

    var body: some View {
        let standing = standingData.standing
        let logoSize: CGFloat = 30

        ZStack {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                // Table zone indicator
                Rectangle()
                    .foregroundColor(colorByPosition(leaguePosition: standing.rank))
                    .frame(width: 4)
                    .padding(1)
                // League position
                Text("\(standing.rank)")
                    .fontWeight(.semibold)
                    .horizPosItem(index: 0, totalWidth: screenWidth)
                // Team
                HStack {
                    // Logo
                    Circle()
                        .foregroundColor(Color.dark2)
                        .frame(width: logoSize, height: logoSize)
                    Text("\(standingData.shortName ?? standing.teamName)")
                        .font(.poppinsFont(fontSize - 1, weight: .regular))
                }
                .frame(width: 0.4 * screenWidth, alignment: .leading)
                .horizPosItem(index: 1, totalWidth: screenWidth)

                // Statistics
                Text("\(standing.played)")
                    .horizPosItem(index: 2, totalWidth: screenWidth)
                Text("\(standing.wins)")
                    .horizPosItem(index: 3, totalWidth: screenWidth)
                Text("\(standing.draws)")
                    .horizPosItem(index: 4, totalWidth: screenWidth)
                Text("\(standing.losses)")
                    .horizPosItem(index: 5, totalWidth: screenWidth)
                Text("\(standing.goalDifference > 0 ? "+" : "")\(standing.goalDifference)")
                    .horizPosItem(index: 6, totalWidth: screenWidth)
                Text("\(standing.points)")
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
        return Color.aclTwo
    case 15, 16:
        return Color.relegation
    default:
        return Color.clear
    }
}
