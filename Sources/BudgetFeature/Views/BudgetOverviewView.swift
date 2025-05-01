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
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)

                if viewModel.isLoading {
                    ProgressView(Localization.loading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .scaleEffect(1.5)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Monthly budget card
                            if let budget = viewModel.monthlyBudget {
                                HStack {
                                    Image(systemName: "calendar.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    VStack(alignment: .leading) {
                                        Text(Localization.monthlyBudget)
                                            .font(.headline)
                                        Text(String(format: Localization.spentBudget, budget.amountSpent, budget.totalBudget))
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }

                            // Categories list card
                            VStack(alignment: .leading, spacing: 10) {
                                Text(Localization.categories)
                                    .font(.headline)
                                    .padding(.bottom, 5)

                                ForEach(viewModel.categories, id: \.name) { category in
                                    NavigationLink(destination: CategoryDetailView(category: category)) {
                                        HStack {
                                            Image(systemName: "folder.fill")
                                                .font(.title2)
                                                .foregroundColor(.orange)
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(category.name.rawValue)
                                                    .font(.headline)
                                                Text(String(format: Localization.spentOfTotal, category.amountSpent, category.totalBudget))
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            Spacer()
                                            ProgressView(value: category.amountSpent, total: category.totalBudget)
                                                .frame(width: 100)
                                        }
                                        .padding()
                                        .background(Color.orange.opacity(0.1))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                            // Pie chart visualization of categories
                            if !viewModel.categories.isEmpty {
                                PieChartView(
                                    data: viewModel.categories.map { category in
                                        ChartDataEntry(
                                            value: category.amountSpent,
                                            label: category.name.rawValue
                                        )
                                    },
                                    title: Localization.pieChartTitle
                                )
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            withAnimation {
                viewModel.loadBudgetData()
            }
        }
        .navigationTitle(Localization.budgetOverviewTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BudgetOverviewView()
}
