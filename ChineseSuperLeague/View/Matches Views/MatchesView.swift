//
//  MatchesView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 22.04.26.
//

import SwiftUI


// (Mock Data)
private let team1 = Team(from: TeamDTO(teamId: 210551171745140, name: TeamNameDTO(full: "Shanghai Shenhua", short: "Shanghai SH"), logoUrl: "", country: "CHN", teamColor: "#115199"))
private let team2 = Team(from: TeamDTO(teamId: 233196699786207, name: TeamNameDTO(full: "Shanghai Port", short: "Shanghai Port"), logoUrl: "", country: "CHN", teamColor: "#D00200"))
private let team3 = Team(from: TeamDTO(teamId: 243648644304690, name: TeamNameDTO(full: "Beijing Guoan", short: "Beijing Guoan"), logoUrl: "", country: "CHN", teamColor: "#1A773E"))
private let team4 = Team(from: TeamDTO(teamId: 347550392128893, name: TeamNameDTO(full: "Chengdu Rongcheng", short: "Chengdu RC"), logoUrl: "", country: "CHN", teamColor: "#BD0102"))

let date1 = DateComponents(calendar: .current, year: 2026, month: 1, day: 1).date!
let date2 = Date()

let spacing: CGFloat = 16


// ----- VIEWS -----

struct MatchdayLabel: View {
    let matchday: Int

    var body: some View {
        let fontSize: CGFloat = 24

        Text("Matchday \(matchday)")
            .padding(36)
            .padding(.bottom, -spacing)
            .font(.ntfGrandFont(fontSize, weight: .bold))
            .textCase(.uppercase)
            .tracking(fontSize * 0.02)
    }
}

struct MatchDateLabel: View {
    let date: Date

    var body: some View {
        HStack {
            Text(date.day)
                .fontWeight(.semibold)
            + Text(" • \(date.date)")
                .foregroundColor(Color.light10)
            Spacer()
        }
        .padding(.horizontal, 16)
        .font(.poppinsFont(12, weight: .regular))
    }
}


struct MatchesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: spacing) {
                // (Mock Data)
                MatchdayLabel(matchday: 5)
                MatchDateLabel(date: date1)
                // Full-time
                MatchCard(homeTeam: team3, awayTeam: team4, date: date1, goals: (1, 2), status: .fullTime, timeElapsed: "")

                MatchDateLabel(date: date2)
                // Live
                MatchCard(homeTeam: team1, awayTeam: team2, date: date1, goals: (1, 0), status: .live, timeElapsed: "90+5'")
                // Half-time
                MatchCard(homeTeam: team3, awayTeam: team4, date: date1, goals: (1, 2), status: .halfTime, timeElapsed: "")

                MatchdayLabel(matchday: 6)
                MatchDateLabel(date: date2)
                // Not started
                MatchCard(homeTeam: team1, awayTeam: team2, date: date1, goals: (1, 0), status: .notStarted, timeElapsed: "")
                // Postponed
                MatchCard(homeTeam: team3, awayTeam: team4, date: date1, goals: (1, 2), status: .postponed, timeElapsed: "")
            }
            .padding(8)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.dark1)
    }
}

#Preview {
    MatchesView()
}
