//
//  File name: BudgetOverviewViewModel.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

@MainActor
class BudgetOverviewViewModel: ObservableObject {
    @Published var monthlyBudget: BudgetCategory? = nil
    @Published var categories: [BudgetCategory] = []
    @Published var isLoading = true
    @Published var isSpinning = false

    private let budgetService: BudgetServiceProtocol

    init(budgetService: BudgetServiceProtocol = ServiceManager.shared.getBudgetService()) {
        self.budgetService = budgetService
    }

    func loadBudgetData() {
        Task {
            isLoading = true
            
            monthlyBudget = await budgetService.fetchMonthlyBudget()
            categories = await budgetService.fetchCategories()
            
            isLoading = false
            isSpinning = false
        }
    }
    
    func loadingIsAppearing() {
        isSpinning = true
    }
    
    func getCurrentDate() -> String {
        DateManager().getFormattedCurrentDate()
    }
    
    func getRemainingBudget() -> String {
        guard let monthlyBudget else { return "0.00" }
        return (monthlyBudget.totalBudget - monthlyBudget.amountSpent).formatCurrency()
    }
    
    func getPercentageValue() -> Int {
        guard let monthlyBudget else { return 0 }
        return Int((monthlyBudget.amountSpent / monthlyBudget.totalBudget) * 100)
    }
    
    func getSpentAmount() -> String {
        guard let monthlyBudget else { return "0.00" }
        return monthlyBudget.amountSpent.formatCurrency()
    }
    
    func getProgressValue() -> Double {
        guard let monthlyBudget else { return 0.0 }
        return min(monthlyBudget.amountSpent / monthlyBudget.totalBudget, 1.0)
    }
    
    func getTotalBudget() -> String {
        guard let monthlyBudget else { return "0.00" }
        return monthlyBudget.totalBudget.formatCurrency()
    }
}
