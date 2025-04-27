//
//  LeagueTableHeader.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 02.01.25.
//

import SwiftUI

struct LeagueTableHeader: View {
    var body: some View {
        ZStack {
            // ZStack & GeometryReader for fixed positioning
            GeometryReader { geometry in
                let screenWidth = geometry.size.width

                Text("Team")
                    .frame(width: 0.4 * screenWidth, alignment: .leading)
                    .horizPosItem(index: 1, totalWidth: screenWidth)
                Text("MP")
                    .horizPosItem(index: 2, totalWidth: screenWidth)
                Text("W")
                    .horizPosItem(index: 3, totalWidth: screenWidth)
                Text("D")
                    .horizPosItem(index: 4, totalWidth: screenWidth)
                Text("L")
                    .horizPosItem(index: 5, totalWidth: screenWidth)
                Text("+/-")
                    .horizPosItem(index: 6, totalWidth: screenWidth)
                Text("Pts")
                    .horizPosItem(index: 7, totalWidth: screenWidth)
            }
        }
        .frame(height: tableRowHeight)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .foregroundColor(Color.dark1)
        .background(Color.accentColor)
        .fontWeight(.bold)
    }
}
