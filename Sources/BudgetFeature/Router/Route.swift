//
//  File name: Route.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

/// Defines all possible navigation destinations within the app
enum Route: Hashable {
    case budgetOverview
    case categoryDetail(category: BudgetCategory)
    case settings
    case notifications
    case addCategory
}