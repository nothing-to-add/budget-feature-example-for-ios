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
            if viewModel.isLoading {
                ProgressView(Localization.loading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scaleEffect(1.5)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    if let budget = viewModel.monthlyBudget {
                        Text(String(format: Localization.spentBudget, budget.amountSpent, budget.totalBudget))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    List(viewModel.categories, id: \.name) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            HStack {
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
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(8)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
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
