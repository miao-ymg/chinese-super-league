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
    let team: Team?

    var body: some View {
        let logoSize: CGFloat = 26

        ZStack {
            if let team, let logo = MemoryCache.getMiniTeamLogo(id: team.id) {
                Image(uiImage: logo)
                    .resizable()
                    .interpolation(.high)
                    .frame(width: logoSize, height: logoSize)
            }
        }
        .frame(width: boxSize, height: boxSize)
        .background(team.map { Color(hex: $0.color) } ?? Color.dark8)
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
    @ObservedObject var vm: MatchesViewModel
    let match: Match
    let home: Team?
    let away: Team?

    var body: some View {
        let spacing: CGFloat = 8
        let fontSize: CGFloat = 12
        let liveCircleSize: CGFloat = 8

        let status = MatchStatus(rawValue: match.status) ?? .unknown

        VStack(spacing: spacing) {
            // Match status
            HStack(spacing: 6) {
                if status == .notStarted {
                    Text(" ")
                } else {
                    Circle()
                        .fill(status.isInPlay ? Color.liveMatch : Color.clear)
                        .frame(width: liveCircleSize, height: liveCircleSize)
                    Text(vm.statusText(status, timeElapsed: (match.timeRegular, match.timeAdded)))
                        .foregroundColor(status.isDisrupted ? Color.warning : Color.white)
                    Color.clear     // Placeholder to keep the match status center-aligned
                        .frame(width: liveCircleSize)
                }
            }

            // Live score
            HStack {
                Text(home?.nameShort ?? match.homeTeamName)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                HStack(spacing: boxSpacing) {
                    LogoBox(team: home)

                    // Scoreboard or Kick-off time
                    if status.isPreMatch {
                        Text(status == .postponed ? "TBD" : match.date?.time ?? "TBD")
                            .frame(width: 2 * boxSize * boxRatio + boxSpacing)
                            .font(.poppinsFont(14, weight: .semibold))
                            .offset(x: 0.5) // (For whatever reason, the text isn't perfectly center-aligned)
                    } else {
                        HStack(spacing: boxSpacing) {
                            GoalBox(goals: match.scoreHome!, status: status)
                            GoalBox(goals: match.scoreAway!, status: status)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: boxCornerRadius))
                    }

                    LogoBox(team: away)
                }
                Text(away?.nameShort ?? match.awayTeamName)
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
