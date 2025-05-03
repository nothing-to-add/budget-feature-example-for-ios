//
//  File name: BudgetCategories.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 30/04/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation
import SwiftUI

enum BudgetCategories: String {
    case food
    case shopping
    case travel
    case monthly
    
    var title: String {
        switch self {
        case .food:
            Localization.Categories.foodTitle
        case .shopping:
            Localization.Categories.shoppingTitle
        case .travel:
            Localization.Categories.travelTitle
        case .monthly:
            Localization.Categories.monthlyTitle
        }
    }
    
    var icon: String {
        switch self {
        case .food:
            Localization.Image.foodIcon
        case .shopping:
            Localization.Image.shoppingIcon
        case .travel:
            Localization.Image.travelIcon
        case .monthly:
            Localization.Image.monthlyIcon
        }
    }
    
    var color: Color {
        switch self {
        case .food:
                .foodCategory
        case .shopping:
                .shoppingCategory
        case .travel:
                .travelCategory
        case .monthly:
                .monthlyCategory
        }
    }
}
