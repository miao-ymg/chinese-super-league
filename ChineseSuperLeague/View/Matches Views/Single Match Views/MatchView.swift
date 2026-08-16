//
//  MatchView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.08.26.
//

import SwiftUI

private let xPadding: CGFloat = 20
private let chevronSize: CGFloat = 16
private let liveCircleSize: CGFloat = 8


struct MatchToolbar: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: MatchViewModel

    var body: some View {
        let status = MatchStatus(vm.match.status)

        HStack {
            // Custom navigation bar back button
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .frame(width: chevronSize)
                    .font(.ntfGrandFont(chevronSize, weight: .semibold))
            }

            Spacer()

            // Match status or match date
            HStack(spacing: 8) {
                Circle()
                    .fill(status.isInPlay ? Color.liveMatch : Color.clear)
                    .frame(width: liveCircleSize, height: liveCircleSize)

                let primaryToolbarText = Text(vm.primaryToolbarText)
                    .foregroundColor(status.isDisrupted ? Color.warning : Color.white)
                    .fontWeight(.semibold)
                Text("\(primaryToolbarText)\(vm.secondaryToolbarText)")

                Color.clear
                    .frame(width: liveCircleSize)
            }

            Spacer()

            Color.clear
                .frame(width: chevronSize)
        }
        .frame(height: chevronSize)
        .padding(.horizontal, xPadding)
        .padding(.vertical, 16)
    }
}


struct MatchView: View {
    @StateObject private var vm: MatchViewModel

    init(match: Match, home: Team?, away: Team?) {
        _vm = StateObject(wrappedValue: MatchViewModel(match: match, home: home, away: away))
    }

    var body: some View {
        VStack(spacing: 0) {
            MatchToolbar(vm: vm)

            Text("\(vm.match.homeTeamName) - \(vm.match.awayTeamName)")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.dark1)
        }
        .background(.dark2)
        .navigationBarBackButtonHidden(true)
        .task {
            await vm.loadMatch()
        }
    }
}
