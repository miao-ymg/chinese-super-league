//
//  CompetitionBar.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 30.03.25.
//

import SwiftUI

struct CompetitionBar: View {
    let fontSize: CGFloat = 20
    let iconSize: CGFloat = 28
    let chevronSize: CGFloat = 16
    let letterSpacing: CGFloat = 0.02

    var body: some View {
        Button {
            // TODO: Open menu to select competition
        } label: {
            HStack {
                // Competition icon
                Image("icon-CSL")
                    .renderingMode(.template)   // "Iconize" image
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .blur(radius: 0.15) // Soften the edges
                // Competition name
                Text("Chinese Super League")
                    .font(.ntfGrandFont(fontSize, weight: .medium))
                    .textCase(.uppercase)
                    .tracking(fontSize * letterSpacing) // Letter spacing
                    .baselineOffset(0.15 * fontSize)

                Image(systemName: "chevron.down")
                    .frame(width: iconSize, height: iconSize)
                    .font(.ntfGrandFont(chevronSize, weight: .medium))
            }
            .padding(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
