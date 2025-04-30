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
    @StateObject private var viewModel: CategoryDetailViewModel

    init(category: BudgetCategory) {
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(category: category))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("Total spent: €\(viewModel.category.amountSpent, specifier: "%.2f")")
                    .font(.headline)
                Text("Remaining: €\(viewModel.category.totalBudget - viewModel.category.amountSpent, specifier: "%.2f")")
                    .font(.subheadline)

                List(viewModel.transactions, id: \.description) { transaction in
                    HStack {
                        Text(transaction.description)
                        Spacer()
                        Text("€\(transaction.amount, specifier: "%.2f")")
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadTransactions()
        }
        .navigationTitle(viewModel.category.name.rawValue)
        .padding()
    }
}

#Preview {
    CategoryDetailView(category: BudgetCategory(name: .food, amountSpent: 300, totalBudget: 400))
}
