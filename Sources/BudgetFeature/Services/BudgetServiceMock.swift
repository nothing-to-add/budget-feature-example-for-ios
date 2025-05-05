//
//  File name: BudgetServiceMock.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

@MainActor
final class BudgetServiceMock: BudgetServiceProtocol {
    
    private let delayTime = 1.0

    func fetchMonthlyBudget() async -> BudgetCategory {
        await performWithDelay(returning: BudgetServiceMockData.monthlyBudget)
    }

    func fetchCategories() async -> [BudgetCategory] {
        await performWithDelay(returning: BudgetServiceMockData.categories)
    }
    
    func fetchTransactions(for category: BudgetCategories) async -> [Transaction] {
        let transactions: [Transaction]
        
        switch category {
        case .food:
            transactions = BudgetServiceMockData.foodTransactions
        case .shopping:
            transactions = BudgetServiceMockData.shoppingTransactions
        case .travel:
            transactions = BudgetServiceMockData.travelTransactions
        case .monthly:
            transactions = [] // Skip monthly category
        }
        
        return await performWithDelay(returning: transactions)
    }
    
}

private extension BudgetServiceMock {
    
    func performWithDelay<T>(returning data: T) async -> T {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                continuation.resume(returning: data)
            }
        }
    }
}
