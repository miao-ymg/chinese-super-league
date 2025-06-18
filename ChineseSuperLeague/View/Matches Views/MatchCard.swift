//
//  MatchCard.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 23.04.25.
//

import SwiftUI

// ----- CONSTANTS -----

let boxSize: CGFloat = 36
let boxSpacing: CGFloat = 2
let boxCornerRadius: CGFloat = boxSpacing
let cardCornerRadius: CGFloat = 12

// ----- VIEWS -----

struct CrestBox: View {
    let teamID: String

    var body: some View {
        let crestSize: CGFloat = 0.8 * boxSize

        ZStack {
            Image("crest-small-\(teamID)")
                .resizable()
                .frame(width: crestSize, height: crestSize)
        }
        .frame(width: boxSize, height: boxSize)
        .background(Color.gray) // (Placeholder)
        .cornerRadius(boxCornerRadius)
    }
}

struct GoalBox: View {
    var goals: Int

    var body: some View {
        let boxRatio: CGFloat = 7/8
        let fontSize: CGFloat = 16

        Text("\(goals)")
            .frame(width: boxSize * boxRatio, height: boxSize)
            .foregroundColor(Color.dark2)
            .background(Color.light1)
            .font(.montserratFont(fontSize, weight: .semibold))
    }
}


struct MatchCard: View {
    let homeTeam: Team
    let awayTeam: Team
    var goals: (Int, Int)
    var matchStatus: String

    var body: some View {
        let fontSize: CGFloat = 11

        VStack(spacing: 0) {
            // Match status
            HStack(spacing: 4) {
                Circle()
                    .fill(Color.matchOngoing)
                    .frame(width: 8, height: 8)
                Text(matchStatus)
                Color.clear     // Placeholder to keep the match status center-aligned
                    .frame(width: 8, height: 8)
            }
            .padding(8)
            // Live score
            HStack {
                Text(homeTeam.nameShort)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                HStack(spacing: boxSpacing) {
                    CrestBox(teamID: homeTeam.id)
                    // Scoreboard or Kick-off time
                    HStack(spacing: boxSpacing) {
                        GoalBox(goals: goals.0)
                        GoalBox(goals: goals.1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: boxCornerRadius))

                    CrestBox(teamID: awayTeam.id)
                }
                Text(awayTeam.nameShort)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.poppinsFont(fontSize + 1, weight: .regular))
            // Final outcome for knockout stage matches (e.g. aggregate score, penalty shootout result)
            Text(" ")
                .foregroundStyle(.secondary)
                .padding(8)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.dark2)
        .cornerRadius(cardCornerRadius)
        .padding(8)
        .font(.poppinsFont(fontSize, weight: .regular))
    }
}

#Preview {
    MatchesView()
}
