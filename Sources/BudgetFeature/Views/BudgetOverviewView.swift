//
//  File name: BudgetOverviewView.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 30/04/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

// Budget Overview View
struct BudgetOverviewView: View {
    @State private var monthlyBudget: (spent: Double, total: Double)? = nil
    @State private var categories: [BudgetCategory] = []
    @State private var isLoading = true

    private let budgetService = BudgetService()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                if isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    if let budget = monthlyBudget {
                        Text("You’ve spent €\(budget.spent, specifier: "%.2f") of your €\(budget.total, specifier: "%.2f") budget")
                            .font(.headline)
                            .padding()
                    }

                    List(categories, id: \.name) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            VStack(alignment: .leading) {
                                Text(category.name)
                                    .font(.headline)
                                HStack {
                                    Text("€\(category.amountSpent, specifier: "%.2f") spent of €\(category.totalBudget, specifier: "%.2f")")
                                        .font(.subheadline)
                                    Spacer()
                                    ProgressView(value: category.amountSpent, total: category.totalBudget)
                                        .frame(width: 100)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    isLoading = true
                    monthlyBudget = await budgetService.fetchMonthlyBudget()
                    categories = await budgetService.fetchCategories()
                    isLoading = false
                }
            }
            .navigationTitle("Budget Overview")
        }
    }
}

#Preview {
    BudgetOverviewView()
}
