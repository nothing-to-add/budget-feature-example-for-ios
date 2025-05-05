//
//  File name: CategoryDetailViewModel.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

@MainActor
class CategoryDetailViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = true
    @Published var isSpinning = false
    let category: BudgetCategory

    private let budgetService: BudgetServiceProtocol

    init(category: BudgetCategory, budgetService: BudgetServiceProtocol = ServiceManager.shared.getBudgetService()) {
        self.category = category
        self.budgetService = budgetService
    }

    func loadTransactions() {
        Task {
            isLoading = true
            transactions = await budgetService.fetchTransactions(for: category.name)
            isLoading = false
            isSpinning = false
        }
    }
    
    func isAppearing() {
        isSpinning = true
    }
    
    func getProgressValue() -> Double {
        min(category.amountSpent / category.totalBudget, 1.0)
    }
    
    func getPercentageProgress() -> Int {
        Int((category.amountSpent / category.totalBudget) * 100)
    }
    
    func getTotalSpent() -> String {
        category.amountSpent.formatCurrency()
    }
    
    func getRemainingBudget() -> String {
        (category.totalBudget - category.amountSpent).formatCurrency()
    }
    
    func getTotalBudget() -> String {
        category.totalBudget.formatCurrency()
    }
}
