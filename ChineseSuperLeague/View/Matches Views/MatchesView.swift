//
//  MatchesView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 22.04.26.
//

import SwiftUI

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
    let date: Date?

    var body: some View {
        HStack {
            if let date {
                Text(date.day)
                    .fontWeight(.semibold)
                + Text(" • \(date.date)")
                    .foregroundColor(Color.light10)
            } else {
                Text("Date TBD")
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .font(.poppinsFont(12, weight: .regular))
    }
}


struct MatchesView: View {
    @StateObject private var vm = MatchesViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: spacing) {
                ForEach(vm.groupedMatches) { mdGroup in
                    MatchdayLabel(matchday: mdGroup.matchday)

                    ForEach(mdGroup.dates) { dateGroup in
                        MatchDateLabel(date: dateGroup.date)

                        ForEach(dateGroup.matches, id: \.match.id) { entry in
                            MatchCard(vm: vm, match: entry.match, home: entry.home, away: entry.away)
                        }
                    }
                }
            }
            .padding(8)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.dark1)

        .task {
            vm.loadAllMatches()
        }
    }
}

#Preview {
    MatchesView()
}
