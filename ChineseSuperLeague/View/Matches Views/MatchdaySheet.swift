//
//  MatchdaySheet.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 05.08.26.
//

import SwiftUI

private let xPaddingSheet: CGFloat = 16
private let xPaddingItem: CGFloat = 16
private let titleFontSize: CGFloat = 24

struct MatchdayItem: View {
    @Binding var isPresentingSheet: Bool
    let selectedMatchday: Int
    let thisMatchday: Int

    var body: some View {
        let isSelected = (thisMatchday == selectedMatchday)
        let foreground = isSelected ? Color.white : Color.dark10
        let background = isSelected ? Color.dark3 : Color.clear

        Button {
            // TODO: Jump to selected matchday
            isPresentingSheet = false
        } label: {
            Text("Matchday \(thisMatchday)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, xPaddingItem)
                .padding(.vertical, 12)
                .foregroundColor(foreground)
                .background(background)
                .cornerRadius(12)
        }
        .disabled(isSelected)
    }
}

struct MatchdaySheet: View {
    @Binding var isPresented: Bool
    let selectedMatchday = 1

    var body: some View {
        VStack(spacing: 0) {
            // Header with close button
            HStack {
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: titleFontSize))
                }
                Spacer()
            }
            .padding(.horizontal, xPaddingItem)
            .padding(.top, xPaddingSheet + xPaddingItem)

            // Sheet title
            Text("Jump to Matchday")
                .frame(height: titleFontSize)
                .padding(.bottom, xPaddingSheet + xPaddingItem)
                .font(.ntfGrandFont(titleFontSize, weight: .bold))
                .textCase(.uppercase)
                .tracking(titleFontSize * 0.02)

            // Matchday picker list
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(1...10, id: \.self) { matchday in
                        MatchdayItem(
                            isPresentingSheet: $isPresented,
                            selectedMatchday: selectedMatchday,
                            thisMatchday: matchday
                        )
                    }
                }
            }
        }
        .padding(.horizontal, xPaddingSheet)
        .presentationBackground(Color.dark2)
        .presentationCornerRadius(xPaddingSheet + xPaddingItem)
        .interactiveDismissDisabled()
    }
}
