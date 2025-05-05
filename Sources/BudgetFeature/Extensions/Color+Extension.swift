//
//  File name: Color+Extension.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 02/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Color {
    
    static var isDarkMode : Bool {
        UITraitCollection.current.userInterfaceStyle == .dark
    }
    
    static let darkNavy: Color = .init(hex: "334155") //Dark Navy
    static let lightOrange: Color = .init(hex: "C87721") //Light Orange instead of 60A5FA
    
    static let foodCategory: Color = .init(hex: "10B981") // Green
    static let shoppingCategory: Color = .init(hex: "3B82F6") // Blue
    static let travelCategory: Color = .init(hex: "8B5CF6") // Purple
    static let monthlyCategory: Color = .init(hex: "F59E0B") // Orange
    
    static let cardBackgroundColor: Color = isDarkMode ? Color(hex: "272741").opacity(0.7) : Color.white.opacity(0.85)
    static let monthlyBackgroundLight: Color = isDarkMode ? Color(hex: "572e01") : Color(hex: "fae2c8") //Light Orange
    static let monthlyBackgroundDark: Color = isDarkMode ? Color(hex: "6b3901") : Color(hex: "face9d") //Darker Orange
    
    static let textMain: Color = isDarkMode ? .white : .darkNavy //Dark Navy
    static let textSecondary: Color = isDarkMode ? Color(hex: "94A3B8") : Color(hex: "64748B") //Light Navy Gray and Dark Navy Gray
    
    static let monthlyCircle: Color = isDarkMode ? .darkNavy.opacity(0.5) : Color(hex: "EFF6FF")
    
}
