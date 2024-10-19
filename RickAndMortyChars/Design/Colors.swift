//
//  Colors.swift
//  RickAndMortyChars
//
//  Created by Andrey Zhelev on 16.10.2024.
//
import UIKit

extension UIColor {
    // Creates color from a hex string
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }

    private static let lightThemeBackground = UIColor.white
    private static let darkThemeBackground = UIColor.black

    private static let lightThemeTextPrimary = UIColor.black
    private static let darkThemeTextPrimary = UIColor.white
    private static let lightThemeTextSecondary = UIColor.darkGray
    private static let darkThemeTextSecondary = UIColor.lightGray
    
    static let cellBackground = UIColor.lightGray.withAlphaComponent(0.2)
    
    static let backgroundColor = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .darkThemeBackground
        : .lightThemeBackground
    }

    static let primaryTextColor = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .darkThemeTextPrimary
        : .lightThemeTextPrimary
    }
    
    static let secondaryTextColor = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .darkThemeTextSecondary
        : .lightThemeTextSecondary
    }
}
