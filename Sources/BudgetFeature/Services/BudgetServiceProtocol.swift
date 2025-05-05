//
//  File name: BudgetServiceProtocol.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

protocol BudgetServiceProtocol: Sendable {
    func fetchMonthlyBudget() async -> BudgetCategory
    func fetchCategories() async -> [BudgetCategory]
    func fetchTransactions(for category: BudgetCategories) async -> [Transaction]
}
