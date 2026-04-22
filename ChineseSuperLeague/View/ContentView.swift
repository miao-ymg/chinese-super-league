//
//  ContentView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 21.04.26.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: Tab = .standings

    let placeholderText = "Page in progress, coming soon! ^^"    // (Temporary)

    var body: some View {
        VStack(spacing: 0) {
            // Top bar to select the football competition
            CompetitionBar()

            // Active tab content
            Group {
                switch activeTab {
                case .rankings:     Text(placeholderText)
                case .standings:    StandingsView()
                case .matches:      Text(placeholderText)
                case .teams:        Text(placeholderText)
                case .settings:     Text(placeholderText)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .safeAreaInset(edge: .bottom) {
            // Custom TabView
            TabBarView(activeTab: $activeTab)
        }
        .background(Color.dark2)
    }
}

#Preview {
    ContentView()
}
