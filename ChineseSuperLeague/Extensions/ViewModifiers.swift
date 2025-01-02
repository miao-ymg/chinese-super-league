//
//  ViewModifiers.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 29.12.24.
//

import SwiftUI

extension View {
    // Percentual horizontal position of a table row item
    func horizPosItem(index: Int, totalWidth: CGFloat) -> some View {
        self.position(x: percentualPositions[index] * totalWidth, y: tableRowHeight / 2)
    }
}
