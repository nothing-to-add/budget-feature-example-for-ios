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
    @EnvironmentObject private var router: BudgetRouter
    
    // Animation states
    @State private var headerAppeared = false
    @State private var budgetCardAppeared = false
    @State private var categoriesAppeared = false
    @State private var chartAppeared = false
    @State private var avatarScale: CGFloat = 0.0
    
    // Color themes based on light/dark mode
    private var backgroundGradient: LinearGradient = .monthlyBackground

    var body: some View {
        ZStack {
            // Elegant gradient background
            backgroundGradient
                .ignoresSafeArea()
            
            // Main content
            if viewModel.isLoading {
                LoadingView(spinnerColor: .monthlyCategory, textColor: .textMain, isSpinning: viewModel.isSpinning, onAppearAction: viewModel.loadingIsAppearing)
            } else {
                ScrollView {
                    VStack(spacing: Constants.Spacing.extraLarge) {
                        // Header with title and avatar
                        headerView
                            .scaleEffect(headerAppeared ? 1.0 : 0.9)
                            .opacity(headerAppeared ? 1.0 : 0)
                        
                        // Monthly budget card with animation
                        if viewModel.monthlyBudget != nil {
                            monthlyBudgetCard()
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
                                        label: category.name.title
                                    )
                                },
                                title: Localization.pieChartTitle
                            )
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
                    .foregroundColor(.textMain)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Navigate to settings
                    router.navigate(to: .settings)
                }) {
                    Image(systemName: Localization.Image.settingIcon)
                        .foregroundColor(.monthlyCategory)
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 38, height: 38)
                        .background(
                            Circle()
                                .fill(Color.monthlyCircle)
                        )
                }
                .buttonStyle(BounceButtonStyle())
            }
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack(spacing: Constants.Spacing.large) {
            // User avatar
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.monthlyCategory, .lightOrange],
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
                .shadow(color: .monthlyCategory.opacity(0.4), radius: 8, x: 0, y: 3)
                .scaleEffect(avatarScale)
            
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                // Greeting
                Text("Hello, Maksim")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.textMain)
                
                // Current date
                Text(viewModel.getCurrentDate())
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            // Notification bell
            Button(action: {
                // Navigate to notifications
                router.navigate(to: .notifications)
            }) {
                Image(systemName: Localization.Image.notificationIcon)
                    .foregroundColor(.monthlyCategory)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 38, height: 38)
                    .background(
                        Circle()
                            .fill(Color.monthlyCircle)
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
        .padding(.horizontal, Constants.Padding.small)
        .padding(.vertical, Constants.Padding.medium)
    }
    
    private func monthlyBudgetCard() -> some View {
        VStack(spacing: Constants.Spacing.heavy) {
            // Top section with icon and title
            HStack {
                Image(systemName: Localization.Image.monthlyBudgetIcon)
                    .font(.system(size: 26))
                    .foregroundColor(.monthlyCategory)
                    .padding(Constants.Padding.medium)
                    .background(
                        Circle()
                            .fill(Color.monthlyCategory.opacity(0.15))
                    )
                
                Text(Localization.monthlyBudget)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(.textMain)
                
                Spacer()
                
                // Month pill
                Text("May")
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, Constants.Padding.large)
                    .padding(.vertical, Constants.Padding.extraSmall)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [.monthlyCategory, .lightOrange],
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
            VStack(spacing: Constants.Spacing.medium) {
                // Budget spent info
                HStack {
                    VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                        Text(Localization.cardSpentTitle)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.textSecondary)
                        
                        Text(viewModel.getSpentAmount())
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(.textMain)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: Constants.Spacing.small) {
                        Text(Localization.cardBudgetTitle)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.textSecondary)
                        
                        Text(viewModel.getTotalBudget())
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundColor(.textMain)
                    }
                }
                
                // Progress bar
                ProgressBar(
                    value: viewModel.getProgressValue(),
                    backgroundColor: .monthlyCategory.opacity(0.2),
                    foregroundColor: .monthlyCategory
                )
                
                // Progress info
                HStack {
                    // Percentage text
                    Text("\(viewModel.getPercentageValue())% used")
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundColor(
                            viewModel.getPercentageValue() > 90 ? Color.red :
                                viewModel.getPercentageValue() > 75 ? Color.orange :
                                    .monthlyCategory
                        )
                    
                    Spacer()
                    
                    // Remaining budget text
                    Text("\(viewModel.getRemainingBudget()) remaining")
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .padding(Constants.Padding.heavy)
        .background(
            GlassmorphicCard(cornerRadius: 20, cardBackgroundColor: .cardBackgroundColor)
        )
        .padding(.horizontal, Constants.Padding.extraSmall)
    }
    
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.large) {
            // Section header
            HStack {
                Text(Localization.categories)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(.textMain)
                
                Spacer()
                
                // Add category button
                Button(action: {
                    // Navigate to add category
                    router.navigate(to: .addCategory)
                }) {
                    Label(Localization.addButtonTitle, systemImage: Localization.Image.addIcon)
                        .font(.system(.subheadline, design: .rounded, weight: .medium))
                        .foregroundColor(.monthlyCategory)
                }
                .buttonStyle(BounceButtonStyle())
            }
            .padding(.horizontal, Constants.Padding.extraSmall)
            
            // Categories list
            VStack(spacing: Constants.Spacing.medium) {
                ForEach(Array(viewModel.categories.enumerated()), id: \.element.name) { index, category in
                    Button(action: {
                        // Navigate to category detail
                        router.navigate(to: .categoryDetail(category: category))
                    }) {
                        categoryCard(category)
                            .background(
                                GlassmorphicCard(cornerRadius: 16, cardBackgroundColor: .cardBackgroundColor)
                            )
                            .transition(.opacity)
                            .animation(.easeOut.delay(Double(index) * 0.1), value: categoriesAppeared)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    private func categoryCard(_ category: BudgetCategory) -> some View {
        HStack(spacing: Constants.Spacing.large) {
            // Category icon
            Image(systemName: category.name.icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(category.name.color)
                )
                .shadow(color: category.name.color.opacity(0.3), radius: 5, x: 0, y: 2)
            
            // Category details
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                Text(category.name.title)
                    .font(.system(.headline, design: .rounded, weight: .semibold))
                    .foregroundColor(.textMain)
                
                Text("\(category.amountSpent.formatCurrency()) of \(category.totalBudget.formatCurrency())")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            // Progress indicator
            VStack(alignment: .trailing, spacing: Constants.Spacing.small) {
                let percentage = Int((category.amountSpent / category.totalBudget) * 100)
                
                Text("\(percentage)%")
                    .font(.system(.subheadline, design: .rounded, weight: .bold))
                    .foregroundColor(
                        percentage > 90 ? Color.red :
                            percentage > 75 ? Color.orange :
                            category.name.color
                    )
                
                ProgressBar(
                    value: min(category.amountSpent / category.totalBudget, 1.0),
                    backgroundColor: category.name.color.opacity(0.2),
                    foregroundColor: category.name.color
                )
                .frame(width: 60, height: 6)
            }
        }
        .padding(.horizontal, Constants.Padding.large)
        .padding(.vertical, Constants.Padding.large)
    }
    
    // MARK: - Helper Methods & Properties
    
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
}

#Preview {
    BudgetOverviewView()
        .environmentObject(BudgetRouter())
}
