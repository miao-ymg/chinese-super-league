//
//  TabBarView.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 21.04.26.
//

import SwiftUI

struct TabItemView: View {
    @Binding var activeTab: Tab
    let thisTab: Tab

    let iconSize: CGFloat = 25

    var body: some View {
        let isSelected = (thisTab == activeTab)
        let tabLabel = thisTab.rawValue

        VStack(spacing: 3) {
            // Tab icon
            Image("icon-\(tabLabel)\(isSelected ? "-filled" : "")")
                .renderingMode(.template)
                .resizable()
                .frame(width: iconSize, height: iconSize)
            // Tab label
            Text(tabLabel.capitalized)
                .font(.poppinsFont(8, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(isSelected ? .accent : .dark10)
        .padding(.top, 12)
        .onTapGesture {
            activeTab = thisTab
        }
    }
}


struct TabBarView: View {
    @Binding var activeTab: Tab

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabItemView(activeTab: $activeTab, thisTab: tab)
            }
        }
        .frame(height: 49)  // Standard iPhone UITabBar height
        .padding(.horizontal, 8)
        .background(.dark2)
        .overlay(alignment: .top) {
            Divider()
        }
    }
}
