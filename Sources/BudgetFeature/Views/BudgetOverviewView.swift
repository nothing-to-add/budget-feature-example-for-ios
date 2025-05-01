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
    @Environment(\.colorScheme) private var colorScheme
    
    // Animation states
    @State private var headerAppeared = false
    @State private var budgetCardAppeared = false
    @State private var categoriesAppeared = false
    @State private var chartAppeared = false
    @State private var avatarScale: CGFloat = 0.0
    
    // Color themes based on light/dark mode
    private var backgroundGradient: LinearGradient {
        colorScheme == .dark ?
            LinearGradient(colors: [Color(hex: "0F172A"), Color(hex: "1E293B")], startPoint: .top, endPoint: .bottom) :
            LinearGradient(colors: [Color(hex: "F0F9FF"), Color(hex: "E0F2FE")], startPoint: .top, endPoint: .bottom)
    }
    
    private var cardBackgroundColor: Color {
        colorScheme == .dark ? Color(hex: "1E293B").opacity(0.7) : Color.white.opacity(0.85)
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "€"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: amount)) ?? String(format: "€%.2f", amount)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Elegant gradient background
                backgroundGradient
                    .ignoresSafeArea()
                
                // Main content
                if viewModel.isLoading {
                    loadingView
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            // Header with title and avatar
                            headerView
                                .scaleEffect(headerAppeared ? 1.0 : 0.9)
                                .opacity(headerAppeared ? 1.0 : 0)
                            
                            // Monthly budget card with animation
                            if let budget = viewModel.monthlyBudget {
                                monthlyBudgetCard(budget)
                                    .transition(.scale.combined(with: .opacity))
                                    .offset(y: budgetCardAppeared ? 0 : 30)
                                    .opacity(budgetCardAppeared ? 1.0 : 0)
                            }
                            
                            // Categories section with staggered animation
                            categoriesSection
                                .offset(y: categoriesAppeared ? 0 : 50)
                                .opacity(categoriesAppeared ? 1.0 : 0)
                            
                            // Pie chart with reveal animation
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
                                .scaleEffect(chartAppeared ? 1.0 : 0.8)
                                .opacity(chartAppeared ? 1.0 : 0)
                            }
                            
                            // Add some space at the bottom for better scrolling experience
                            Spacer().frame(height: 20)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                viewModel.loadBudgetData()
                animateViewsIn()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Localization.budgetOverviewTitle)
                        .font(.system(.headline, design: .rounded, weight: .bold))
                        .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Settings action
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(Color(hex: "3B82F6"))
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 38, height: 38)
                            .background(
                                Circle()
                                    .fill(colorScheme == .dark ? 
                                          Color(hex: "334155").opacity(0.5) : 
                                          Color(hex: "EFF6FF"))
                            )
                    }
                    .buttonStyle(BounceButtonStyle())
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack(spacing: 16) {
            // User avatar
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "3B82F6"), Color(hex: "60A5FA")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .overlay(
                    Text("ML")
                        .font(.system(.headline, design: .rounded, weight: .bold))
                        .foregroundColor(.white)
                )
                .shadow(color: Color(hex: "3B82F6").opacity(0.4), radius: 8, x: 0, y: 3)
                .scaleEffect(avatarScale)
            
            VStack(alignment: .leading, spacing: 4) {
                // Greeting
                Text("Hello, Maksim")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
                
                // Current date
                Text("2 May 2025")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? Color(hex: "94A3B8") : Color(hex: "64748B"))
            }
            
            Spacer()
            
            // Notification bell
            Button(action: {
                // Notification action
            }) {
                Image(systemName: "bell.fill")
                    .foregroundColor(Color(hex: "3B82F6"))
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 38, height: 38)
                    .background(
                        Circle()
                            .fill(colorScheme == .dark ? 
                                 Color(hex: "334155").opacity(0.5) : 
                                 Color(hex: "EFF6FF"))
                    )
                    .overlay(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 9, y: -9),
                        alignment: .topTrailing
                    )
            }
            .buttonStyle(BounceButtonStyle())
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
    }
    
    private func monthlyBudgetCard(_ budget: BudgetCategory) -> some View {
        VStack(spacing: 20) {
            // Top section with icon and title
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color(hex: "3B82F6"))
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color(hex: "3B82F6").opacity(0.15))
                    )
                
                Text(Localization.monthlyBudget)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
                
                Spacer()
                
                // Month pill
                Text("May")
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "3B82F6"), Color(hex: "60A5FA")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
            }
            
            // Divider
            Rectangle()
                .fill(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.05))
                .frame(height: 1)
            
            // Budget progress section
            VStack(spacing: 12) {
                // Budget spent info
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Spent")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(colorScheme == .dark ? Color(hex: "94A3B8") : Color(hex: "64748B"))
                        
                        Text(formatCurrency(budget.amountSpent))
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Budget")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(colorScheme == .dark ? Color(hex: "94A3B8") : Color(hex: "64748B"))
                        
                        Text(formatCurrency(budget.totalBudget))
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
                    }
                }
                
                // Progress bar
                ProgressBar(
                    value: min(budget.amountSpent / budget.totalBudget, 1.0),
                    backgroundColor: Color(hex: "3B82F6").opacity(0.2),
                    foregroundColor: Color(hex: "3B82F6")
                )
                
                // Progress info
                HStack {
                    let percentage = Int((budget.amountSpent / budget.totalBudget) * 100)
                    let remainingBudget = budget.totalBudget - budget.amountSpent
                    
                    // Percentage text
                    Text("\(percentage)% used")
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundColor(
                            percentage > 90 ? Color.red :
                                percentage > 75 ? Color.orange :
                                Color(hex: "3B82F6")
                        )
                    
                    Spacer()
                    
                    // Remaining budget text
                    Text("\(formatCurrency(remainingBudget)) remaining")
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundColor(colorScheme == .dark ? Color(hex: "94A3B8") : Color(hex: "64748B"))
                }
            }
        }
        .padding(20)
        .background(
            glassmorphicCard(cornerRadius: 20)
        )
        .padding(.horizontal, 4)
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section header
            HStack {
                Text(Localization.categories)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
                
                Spacer()
                
                // Add category button
                Button(action: {
                    // Add category action
                }) {
                    Label("Add", systemImage: "plus")
                        .font(.system(.subheadline, design: .rounded, weight: .medium))
                        .foregroundColor(Color(hex: "3B82F6"))
                }
                .buttonStyle(BounceButtonStyle())
            }
            .padding(.horizontal, 4)
            
            // Categories list
            VStack(spacing: 12) {
                ForEach(Array(viewModel.categories.enumerated()), id: \.element.name) { index, category in
                    NavigationLink(destination: CategoryDetailView(category: category)) {
                        categoryCard(category)
                            .background(
                                glassmorphicCard(cornerRadius: 16)
                            )
                            .transition(.opacity)
                            .animation(.easeOut.delay(Double(index) * 0.1), value: categoriesAppeared)
                    }
                }
            }
        }
    }
    
    private func categoryCard(_ category: BudgetCategory) -> some View {
        HStack(spacing: 16) {
            // Category icon
            Image(systemName: iconForCategory(category))
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colorForCategory(category))
                )
                .shadow(color: colorForCategory(category).opacity(0.3), radius: 5, x: 0, y: 2)
            
            // Category details
            VStack(alignment: .leading, spacing: 6) {
                Text(category.name.rawValue)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
                
                Text("\(formatCurrency(category.amountSpent)) of \(formatCurrency(category.totalBudget))")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? Color(hex: "94A3B8") : Color(hex: "64748B"))
            }
            
            Spacer()
            
            // Progress indicator
            VStack(alignment: .trailing, spacing: 6) {
                let percentage = Int((category.amountSpent / category.totalBudget) * 100)
                
                Text("\(percentage)%")
                    .font(.system(.subheadline, design: .rounded, weight: .bold))
                    .foregroundColor(
                        percentage > 90 ? Color.red :
                            percentage > 75 ? Color.orange :
                            colorForCategory(category)
                    )
                
                ProgressBar(
                    value: min(category.amountSpent / category.totalBudget, 1.0),
                    backgroundColor: colorForCategory(category).opacity(0.2),
                    foregroundColor: colorForCategory(category)
                )
                .frame(width: 60, height: 6)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            // Shimmer effect placeholder or spinner
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color(hex: "3B82F6").opacity(0.2), Color(hex: "3B82F6")]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(isLoading ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
                .onAppear { isLoading = true }
            
            Text(Localization.loading)
                .font(.system(.title3, design: .rounded, weight: .medium))
                .foregroundColor(colorScheme == .dark ? .white : Color(hex: "334155"))
        }
    }
    
    // MARK: - Helper Views
    
    private func glassmorphicCard(cornerRadius: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(cardBackgroundColor)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Material.ultraThinMaterial)
            )
            .shadow(
                color: colorScheme == .dark ?
                    Color.black.opacity(0.3) :
                    Color.black.opacity(0.07),
                radius: 10, x: 0, y: 5
            )
    }
    
    // MARK: - Helper Methods & Properties
    
    @State private var isLoading = false
    
    private func animateViewsIn() {
        // Staggered animations for a smooth reveal effect
        withAnimation(.easeOut.delay(0.1)) {
            headerAppeared = true
        }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7).delay(0.1)) {
            avatarScale = 1.0
        }
        
        withAnimation(.easeOut.delay(0.3)) {
            budgetCardAppeared = true
        }
        
        withAnimation(.easeOut.delay(0.5)) {
            categoriesAppeared = true
        }
        
        withAnimation(.easeOut.delay(0.7)) {
            chartAppeared = true
        }
    }
    
    private func colorForCategory(_ category: BudgetCategory) -> Color {
        switch category.name {
        case .food:
            return Color(hex: "10B981") // Green
        case .shopping:
            return Color(hex: "3B82F6") // Blue
        case .travel:
            return Color(hex: "8B5CF6") // Purple
        case .monthly:
            return Color(hex: "F59E0B") // Orange
        }
    }
    
    private func iconForCategory(_ category: BudgetCategory) -> String {
        switch category.name {
        case .food:
            return "fork.knife"
        case .shopping:
            return "bag.fill"
        case .travel:
            return "airplane"
        case .monthly:
            return "calendar"
        }
    }
}

#Preview {
    BudgetOverviewView()
}
