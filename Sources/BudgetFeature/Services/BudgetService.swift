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

@MainActor
class BudgetService {
    func fetchMonthlyBudget() async -> (spent: Double, total: Double) {
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate 1-second delay
        } catch {
            print("Error during sleep: \(error)")
        }
        return (spent: 500, total: 1000)
    }

    func fetchCategories() async -> [BudgetCategory] {
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate 1-second delay
        } catch {
            print("Error during sleep: \(error)")
        }
        return [
            BudgetCategory(name: "Food", amountSpent: 200, totalBudget: 300),
            BudgetCategory(name: "Shopping", amountSpent: 150, totalBudget: 200),
            BudgetCategory(name: "Travel", amountSpent: 100, totalBudget: 500)
        ]
    }

    func fetchTransactions(for category: String) async -> [Transaction] {
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate 1-second delay
        } catch {
            print("Error during sleep: \(error)")
        }
        return [
            Transaction(description: "Grocery Store", amount: 30),
            Transaction(description: "Restaurant", amount: 50),
            Transaction(description: "Cafe", amount: 20)
        ]
    }
}
