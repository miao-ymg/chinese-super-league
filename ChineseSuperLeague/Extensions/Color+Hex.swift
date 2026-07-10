//
//  Color+Hex.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 10.07.26.
//

import SwiftUI

extension Color {
    /// Initializes a Color from a hex string
    init(hex: String) {
        let cleanHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")

        // Return no color, if hex cannot be parsed
        guard cleanHex.count == 6,
              let rgb = UInt64(cleanHex, radix: 16) else {
            self = .clear
            return
        }

        let red = Double((rgb >> 16) & 0xFF) / 255
        let green = Double((rgb >> 8) & 0xFF) / 255
        let blue = Double(rgb & 0xFF) / 255

        self.init(red: red, green: green, blue: blue)
    }
}
