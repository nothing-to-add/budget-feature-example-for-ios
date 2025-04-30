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
    @StateObject private var viewModel = BudgetOverviewViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    if let budget = viewModel.monthlyBudget {
                        Text("You’ve spent €\(budget.amountSpent, specifier: "%.2f") of your €\(budget.totalBudget, specifier: "%.2f") budget")
                            .font(.headline)
                            .padding()
                    }

                    List(viewModel.categories, id: \.name) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            VStack(alignment: .leading) {
                                Text(category.name.rawValue)
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
                viewModel.loadBudgetData()
            }
            .navigationTitle("Budget Overview")
        }
    }
}

#Preview {
    BudgetOverviewView()
}
