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
    @Environment(\.dismiss) private var dismiss

    init(category: BudgetCategory) {
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(category: category))
    }

    var body: some View {
        ZStack {
            // Common background color for the entire screen
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)

            if viewModel.isLoading {
                ProgressView(Localization.loading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scaleEffect(1.5)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Title card
                        Text(viewModel.category.name.rawValue)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .cornerRadius(10)
                            .padding(.horizontal)

                        HStack {
                            // Total spent card
                            HStack {
                                Image(systemName: "eurosign.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                VStack(alignment: .leading) {
                                    Text(Localization.totalSpent)
                                        .font(.headline)
                                    Text("€\(viewModel.category.amountSpent, specifier: "%.2f")")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                            }
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                            
                            Spacer()

                            // Remaining budget card
                            HStack {
                                Image(systemName: "wallet.pass.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.orange)
                                VStack(alignment: .leading) {
                                    Text(Localization.remainingBudget)
                                        .font(.headline)
                                    Text("€\(viewModel.category.totalBudget - viewModel.category.amountSpent, specifier: "%.2f")")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                            }
                            .padding()
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        // Transactions list card
                        VStack(alignment: .leading, spacing: 10) {
                            Text(Localization.transactions)
                                .font(.headline)
                                .padding(.bottom, 5)

                            ForEach(viewModel.transactions, id: \.description) { transaction in
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
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadTransactions()
        }
        .navigationTitle("")
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
    }
}

#Preview {
    CategoryDetailView(category: BudgetCategory(name: .food, amountSpent: 300, totalBudget: 400))
}
