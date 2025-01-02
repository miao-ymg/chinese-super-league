//
//  CustomFontExtension.swift
//  ChinaSuperLeague
//
//  Created by Sam Miao on 11.09.24.
//

import SwiftUI

extension Font {
    // Poppins Font
    static func poppinsFont(_ size: CGFloat, weight: Font.Weight) -> Font {
        switch weight {
        case .semibold:
            return .custom("Poppins-SemiBold", size: size)
        case .bold:
            return .custom("Poppins-Bold", size: size)
        default:
            return .custom("Poppins-Regular", size: size)
        }
    }

    // NTF-Grand Italic Font
    static func ntfGrandItalicFont(_ size: CGFloat, weight: Font.Weight) -> Font {
        switch weight {
        case .medium:
            return .custom("NTF-Grand-MediumItalic", size: size)
        default:
            return .custom("NTF-Grand-Italic", size: size)
        }
    }
}
