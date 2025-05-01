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
import Charts

// Budget Overview View
struct BudgetOverviewView: View {
    @StateObject private var viewModel = BudgetOverviewViewModel()

    var body: some View {
        NavigationView {
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

struct PieChartView: View {
    let data: [ChartDataEntry]
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Chart(data) { entry in
                SectorMark(
                    angle: .value("Value", entry.value),
                    innerRadius: .ratio(0.5),
                    outerRadius: .ratio(1.0)
                )
                .foregroundStyle(by: .value("Label", entry.label))
            }
        }
    }
}

struct ChartDataEntry: Identifiable {
    let id = UUID()
    let value: Double
    let label: String
}

#Preview {
    BudgetOverviewView()
}
