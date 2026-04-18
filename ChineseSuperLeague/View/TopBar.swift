//
//  TopBar.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 17.04.26.
//

import SwiftUI

struct TopBar: View {
    let iconSize: CGFloat = 26
    let fontSize: CGFloat = 20
    let letterSpacing: CGFloat = 0.02

    var body: some View {
        Button {
            // TODO: Open menu to select competition
        } label: {
            HStack(alignment: .bottom) {
                // Competition icon
                Image("icon-CSL")
                    .renderingMode(.template)   // "Iconize" image
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                // Competition name
                Text("Chinese Super League")
                    .font(.ntfGrandFont(fontSize, weight: .medium))
                    .textCase(.uppercase)
                    .tracking(fontSize * letterSpacing) // Letter spacing

                Image(systemName: "chevron.down")
                    .frame(width: iconSize, height: iconSize)
                    .fontWeight(.bold)
            }
            .padding(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

