//
//  MatchesView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 22.04.26.
//

import SwiftUI

private let spacing: CGFloat = 16
private let xPaddingPicker: CGFloat = 16
private let yPaddingPicker: CGFloat = 24
private let matchesFontSize: CGFloat = 12


// ----- VIEWS -----

struct MatchdayPicker: View {
    @State private var isShowingMatchdaySheet = false

    var body: some View {
        Button {
            isShowingMatchdaySheet = true
        } label: {
            HStack {
                Text("Matchday X")
                Spacer()
                Image(systemName: "chevron.down")
            }
            .padding(16)
            .font(.poppinsFont(matchesFontSize, weight: .regular))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 2)
                .strokeBorder(.dark3, lineWidth: 2)
        )

        .sheet(isPresented: $isShowingMatchdaySheet) {
            MatchdaySheet(isPresented: $isShowingMatchdaySheet)
                .presentationDetents([.medium])
        }
    }
}

struct MatchdayLabel: View {
    let matchday: Int

    var body: some View {
        let fontSize: CGFloat = 24

        Text("Matchday \(matchday)")
            .padding(.top, spacing)
            .padding(.bottom, yPaddingPicker)
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
    }
}


struct MatchesView: View {
    @StateObject private var vm = MatchesViewModel()

    var body: some View {
        VStack(spacing: 0) {
            MatchdayPicker()
                .padding(.horizontal, xPaddingPicker)
                .padding(.vertical, yPaddingPicker)

            ScrollView {
                VStack(spacing: spacing) {
                    ForEach(vm.groupedMatches) { mdGroup in
                        MatchdayLabel(matchday: mdGroup.matchday)
                            .id(mdGroup.id)

                        ForEach(mdGroup.dates) { dateGroup in
                            MatchDateLabel(date: dateGroup.date)
                                .id(dateGroup.id)

                            ForEach(dateGroup.matches, id: \.match.id) { entry in
                                NavigationLink {
                                    // Navigate to MatchView for the selected match
                                    MatchView(match: entry.match, home: entry.home, away: entry.away)
                                } label: {
                                    MatchCard(vm: vm, match: entry.match, home: entry.home, away: entry.away)
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        Spacer()
                            .frame(height: 0)
                    }
                }
            }
            .padding(.horizontal, 8)
            .font(.poppinsFont(matchesFontSize, weight: .regular))

            .scrollPosition(id: $vm.scrollTarget, anchor: .top)
            .defaultScrollAnchor(.bottom)   // Fallback position (when season has concluded)
            .task {
                vm.loadAllMatches()
                vm.initScrollTarget()
            }
        }
        .background(Color.dark1)
    }
}

#Preview {
    MatchesView()
}
