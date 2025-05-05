//
//  File name: LinearGradient+Extension.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation
import SwiftUI
import UIKit

extension LinearGradient {
    
    static var isDarkMode : Bool {
        UITraitCollection.current.userInterfaceStyle == .dark
    }
    
    static var monthlyBackground: LinearGradient {
        isDarkMode ?
            LinearGradient(colors: [Color(hex: "572e01"), Color(hex: "6b3901")], startPoint: .top, endPoint: .bottom) :
        LinearGradient(colors: [Color(hex: "fae2c8"), Color(hex: "face9d")], startPoint: .top, endPoint: .bottom)
    }
}
