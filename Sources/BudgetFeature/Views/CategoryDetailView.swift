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
import Charts

// Category Detail View
struct CategoryDetailView: View {
    @StateObject private var viewModel: CategoryDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(category: BudgetCategory) {
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(category: category))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView(Localization.loading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scaleEffect(1.5)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Text(String(format: Localization.totalSpent, viewModel.category.amountSpent))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.2), Color.green.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Text(String(format: Localization.remainingBudget, viewModel.category.totalBudget - viewModel.category.amountSpent))
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)

                    List(viewModel.transactions, id: \.description) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transaction.description)
                                    .font(.headline)
                                Text("€\(transaction.amount, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(8)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
        .onAppear {
            viewModel.loadTransactions()
        }
        .navigationTitle(viewModel.category.name.rawValue)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
            }
        }
        .padding()
    }
}

#Preview {
    CategoryDetailView(category: BudgetCategory(name: .food, amountSpent: 300, totalBudget: 400))
}
