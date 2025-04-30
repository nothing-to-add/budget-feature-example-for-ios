//
//  File name: CategoryDetailView.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 30/04/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

// Category Detail View
struct CategoryDetailView: View {
    let category: BudgetCategory
    @State private var transactions: [Transaction] = []
    @State private var isLoading = true

    private let budgetService = BudgetService()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("Total spent: €\(category.amountSpent, specifier: "%.2f")")
                    .font(.headline)
                Text("Remaining: €\(category.totalBudget - category.amountSpent, specifier: "%.2f")")
                    .font(.subheadline)

                List(transactions, id: \.description) { transaction in
                    HStack {
                        Text(transaction.description)
                        Spacer()
                        Text("€\(transaction.amount, specifier: "%.2f")")
                    }
                }
            }
        }
        .onAppear {
            Task {
                isLoading = true
                transactions = await budgetService.fetchTransactions(for: category.name)
                isLoading = false
            }
        }
        .navigationTitle(category.name)
        .padding()
    }
}

#Preview {
    CategoryDetailView(category: BudgetCategory(name: "Name", amountSpent: 300, totalBudget: 400))
}
