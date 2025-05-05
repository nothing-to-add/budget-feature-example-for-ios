//
//  File name: BudgetCategory.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 30/04/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

/// Data model for Budget categories
struct BudgetCategory: Hashable, Equatable {
    let name: BudgetCategories
    let amountSpent: Double
    let totalBudget: Double
}
