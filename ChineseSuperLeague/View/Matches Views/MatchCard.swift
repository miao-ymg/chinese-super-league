//
//  MatchCard.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 22.04.26.
//

import SwiftUI

// ----- CONSTANTS -----

let boxSize: CGFloat = 36
let boxRatio: CGFloat = 7/8
let boxSpacing: CGFloat = 2
let boxCornerRadius: CGFloat = boxSpacing
let cardCornerRadius: CGFloat = 12

// ----- VIEWS -----

struct LogoBox: View {
    let teamID: Int
    let color: Color

    var body: some View {
        let logoSize: CGFloat = 26

        ZStack {
            if let logo = MemoryCache.getMiniTeamLogo(id: teamID) {
                Image(uiImage: logo)
                    .resizable()
                    .interpolation(.high)
                    .frame(width: logoSize, height: logoSize)
            }
        }
        .frame(width: boxSize, height: boxSize)
        .background(color)
        .cornerRadius(boxCornerRadius)
    }
}

struct GoalBox: View {
    var goals: Int
    var status: MatchStatus

    var body: some View {
        let fontSize: CGFloat = 16

        let foreground = status.isInPlay ? Color.dark2 : Color.white
        let background = status.isInPlay ? Color.white : Color.dark4

        Text("\(goals)")
            .frame(width: boxSize * boxRatio, height: boxSize)
            .foregroundColor(foreground)
            .background(background)
            .font(.montserratFont(fontSize, weight: .semibold))
    }
}


struct MatchCard: View {
    let homeTeam: Team
    let awayTeam: Team
    let date: Date
    var goals: (Int, Int)
    var status: MatchStatus
    var timeElapsed: String

    var body: some View {
        let spacing: CGFloat = 8
        let fontSize: CGFloat = 12
        let liveCircleSize: CGFloat = 8

        VStack(spacing: spacing) {
            // Match status
            HStack(spacing: 6) {
                if status == .notStarted {
                    Text(" ")
                } else {
                    Circle()
                        .fill(status.isInPlay ? Color.liveMatch : Color.clear)
                        .frame(width: liveCircleSize, height: liveCircleSize)
                    Text(status == .live ? timeElapsed : status.rawValue)
                        .foregroundColor(status.isDisrupted ? Color.warning : Color.white)
                    Color.clear     // Placeholder to keep the match status center-aligned
                        .frame(width: liveCircleSize)
                }
            }

            // Live score
            HStack {
                Text(homeTeam.nameShort)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                HStack(spacing: boxSpacing) {
                    LogoBox(teamID: homeTeam.id, color: Color(hex: homeTeam.color))

                    // Scoreboard or Kick-off time
                    if status.isPreMatch {
                        Text(status == .postponed ? "TBD" : date.time)
                            .frame(width: 2 * boxSize * boxRatio + boxSpacing)
                            .font(.poppinsFont(14, weight: .semibold))
                            .offset(x: 0.5) // (For whatever reason, the text isn't perfectly center-aligned)
                    } else {
                        HStack(spacing: boxSpacing) {
                            GoalBox(goals: goals.0, status: status)
                            GoalBox(goals: goals.1, status: status)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: boxCornerRadius))
                    }

                    LogoBox(teamID: awayTeam.id, color: Color(hex: awayTeam.color))
                }
                Text(awayTeam.nameShort)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .lineLimit(1)
            .truncationMode(.tail)

            // Final outcome for knockout stage matches (e.g. aggregate score, penalty shootout result)
            Text(" ")
                .foregroundStyle(Color.light10)
        }
        .padding(.vertical, spacing)
        .background(Color.dark2)
        .cornerRadius(cardCornerRadius)
        .font(.poppinsFont(fontSize, weight: .regular))
    }
}

#Preview {
    MatchesView()
}
