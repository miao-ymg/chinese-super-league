//
//  MatchView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.08.26.
//

import SwiftUI

struct MatchView: View {
    @StateObject private var vm: MatchViewModel

    init(match: Match, home: Team?, away: Team?) {
        _vm = StateObject(wrappedValue: MatchViewModel(match: match, home: home, away: away))
    }

    var body: some View {
        Text("\(vm.match.homeTeamName) - \(vm.match.awayTeamName)")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.dark1)
            .task {
                await vm.loadMatch()
            }
    }
}
