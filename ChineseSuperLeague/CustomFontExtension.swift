//
//  CustomFontExtension.swift
//  ChineseSuperLeague
//
//  Created by Sam Miao on 15.04.26.
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

    // NTF-Grand Font
    static func ntfGrandFont(_ size: CGFloat, weight: Font.Weight) -> Font {
        switch weight {
        case .medium:
            return .custom("NTF-Grand-Medium", size: size)
        default:
            return .custom("NTF-Grand-Regular", size: size)
        }
    }
}
