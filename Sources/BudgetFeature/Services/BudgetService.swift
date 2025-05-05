//
//  File name: BudgetService.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 30/04/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

final class BudgetService: BudgetServiceProtocol {
    
    func fetchMonthlyBudget() async -> BudgetCategory {
        //Placeholder for HTTPS request
        return .init(name: BudgetCategories.food, amountSpent: 0, totalBudget: 0)
    }
    
    func fetchCategories() async -> [BudgetCategory] {
        //Placeholder for HTTPS request
        return []
    }
    
    func fetchTransactions(for category: BudgetCategories) async -> [Transaction] {
        //Placeholder for HTTPS request
        return []
    }
}
