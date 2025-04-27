//
//  ContentView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 04.04.25.
//

import SwiftUI

struct TabItemView: View {
    let tabLabel: String
    let currentTab: String

    var body: some View {
        let isSelected = (currentTab == tabLabel)

        Image("icon-\(tabLabel)\(isSelected ? "-filled" : "")")
            .renderingMode(.template)
        Text(tabLabel.capitalized)
    }
}


// ----- CONTENT VIEW -----

struct ContentView: View {
    @State private var currentTab = "matches"

    let tabItemTags = ["rankings", "standings", "matches", "clubs", "settings"]
    let placeholderText = "Page in progress, coming soon! ^^"    // (Temporary)

    var body: some View {
        VStack(spacing: 0) {
            // Top bar to select the football competition
            CompetitionBar()

            TabView(selection: $currentTab) {
                Text(placeholderText)
                    .tabItem {
                        TabItemView(tabLabel: tabItemTags[0], currentTab: currentTab)
                    }
                    .tag(tabItemTags[0])

                StandingsView()
                    .tabItem {
                        TabItemView(tabLabel: tabItemTags[1], currentTab: currentTab)
                    }
                    .tag(tabItemTags[1])

                MatchesView()
                    .tabItem {
                        TabItemView(tabLabel: tabItemTags[2], currentTab: currentTab)
                    }
                    .tag(tabItemTags[2])

                Text(placeholderText)
                    .tabItem {
                        TabItemView(tabLabel: tabItemTags[3], currentTab: currentTab)
                    }
                    .tag(tabItemTags[3])

                Text(placeholderText)
                    .tabItem {
                        TabItemView(tabLabel: tabItemTags[4], currentTab: currentTab)
                    }
                    .tag(tabItemTags[4])
            }
        }
        .foregroundColor(Color.light1)
        .background(Color.dark2)
    }
}

#Preview {
    ContentView()
}
