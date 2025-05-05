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
    @Environment(\.colorScheme) private var colorScheme
    
    // Animation states
    @State private var headerAppeared = false
    @State private var cardsAppeared = false
    @State private var transactionsAppeared = false
    @State private var floatingButtonScale = 0.0
    
    init(category: BudgetCategory) {
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(category: category))
    }
    
    // Color themes based on light/dark mode
    private var backgroundGradient: LinearGradient {
        colorScheme == .dark ?
            LinearGradient(colors: [Color.black, Color(hex: "1A1A2E")], startPoint: .top, endPoint: .bottom) :
            LinearGradient(colors: [Color(hex: "F9FAFB"), Color(hex: "EEF2FF")], startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        ZStack {
            // Fancy gradient background
            backgroundGradient.ignoresSafeArea()
            
            if viewModel.isLoading {
                LoadingView(spinnerColor: viewModel.category.name.color, textColor: .textMain, isSpinning: viewModel.isSpinning, onAppearAction: viewModel.isAppearing)
            } else {
                
                // Main content
                ScrollView {
                    VStack(spacing: 25) {
                        // Fancy header with category name and visualizer
                        headerView
                            .padding(.top, 20)
                            .scaleEffect(headerAppeared ? 1.0 : 0.9)
                            .opacity(headerAppeared ? 1.0 : 0)
                        
                        // Budget stats with glassmorphic cards
                        budgetStatsView
                            .offset(y: cardsAppeared ? 0 : 50)
                            .opacity(cardsAppeared ? 1.0 : 0)
                        
                        // Transactions with animated appearance
                        transactionsView
                            .offset(y: transactionsAppeared ? 0 : 100)
                            .opacity(transactionsAppeared ? 1.0 : 0)
                        
                        Spacer(minLength: 90) // Space for floating button
                    }
                    .padding(.horizontal)
                }
//                .overlay(loadingOverlay)
                
                // Floating action button
                VStack {
                    Spacer()
                    
                    floatingActionButton
                        .scaleEffect(floatingButtonScale)
                        .padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            viewModel.loadTransactions()
            animateViewsIn()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }
    
    // MARK: - Sub Views
    
    private var headerView: some View {
        VStack(spacing: 15) {
            // Category icon in shimmering circle
            ZStack {
                Circle()
                    .fill(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                viewModel.category.name.color.opacity(0.8),
                                viewModel.category.name.color,
                                viewModel.category.name.color.opacity(0.4),
                                viewModel.category.name.color.opacity(0.8)
                            ]),
                            center: .center
                        )
                    )
                    .frame(width: 100, height: 100)
                    .shadow(color: viewModel.category.name.color.opacity(0.5), radius: 15, x: 0, y: 5)
                
                Image(systemName: viewModel.category.name.icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 8)
            
            // Category name with stylish typography
            Text(viewModel.category.name.title)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [viewModel.category.name.color, viewModel.category.name.color.opacity(0.7)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: colorScheme == .dark ? .clear : viewModel.category.name.color.opacity(0.2), radius: 2, x: 0, y: 2)
            
            // Budget progress indicator
            budgetProgressView
                .padding(.top, 5)
                .padding(.horizontal, 20)
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(
            GlassmorphicCard(cornerRadius: 25, cardBackgroundColor: .cardBackgroundColor)
        )
    }
    
    private var budgetProgressView: some View {
        VStack(spacing: 12) {
            // Progress bar
            ProgressBar(
                value: viewModel.getProgressValue(),
                backgroundColor: viewModel.category.name.color.opacity(0.2),
                foregroundColor: viewModel.category.name.color
            )
            
            // Budget values with percentage
            HStack {
                // Spent amount
                Text(viewModel.getTotalSpent())
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
                
                Spacer()
                
                // Budget percentage
                let percentage = viewModel.getPercentageProgress()
                Text("\(percentage)%")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(
                        percentage > 90 ? .red : 
                        percentage > 75 ? .orange : 
                            viewModel.category.name.color
                    )
                
                Spacer()
                
                // Total budget
                Text(viewModel.getTotalBudget())
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
            }
        }
    }
    
    private var budgetStatsView: some View {
        HStack(spacing: 15) {
            // Total spent card
            statCard(
                title: Localization.totalSpent,
                value: viewModel.getTotalSpent(),
                icon: Localization.Image.totalSpentIcon,
                iconColor: .green,
                gradientColors: [Color.green.opacity(0.8), Color.green.opacity(0.4)]
            )
            
            // Remaining budget card
            statCard(
                title: Localization.remainingBudget,
                value: viewModel.getRemainingBudget(),
                icon: Localization.Image.remainingBudgetIcon,
                iconColor: .orange,
                gradientColors: [Color.orange.opacity(0.8), Color.orange.opacity(0.4)]
            )
        }
    }
    
    private var transactionsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section title with icon
            HStack {
                Image(systemName: Localization.Image.transactionListIcon)
                    .font(.title2)
                    .foregroundColor(viewModel.category.name.color)
                
                Text(Localization.transactions)
                    .font(.title2.bold())
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 8)
            
            if viewModel.transactions.isEmpty {
                // Empty state display
                emptyTransactionsView
            } else {
                // Transactions list with fancy cards
                VStack(spacing: 12) {
                    ForEach(Array(viewModel.transactions.enumerated()), id: \.element.description) { index, transaction in
                        transactionCard(transaction: transaction)
                            .transition(.asymmetric(
                                insertion: .scale.combined(with: .opacity),
                                removal: .opacity
                            ))
                            .animation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.1).delay(Double(index) * 0.05), value: transactionsAppeared)
                    }
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            GlassmorphicCard(cornerRadius: 20, cardBackgroundColor: .cardBackgroundColor)
        )
    }
    
    private var emptyTransactionsView: some View {
        VStack(spacing: 15) {
            Image(systemName: Localization.Image.emptyTransactionIcon)
                .font(.system(size: 40))
                .foregroundColor(.secondary)
            
            Text(Localization.emptyTransactionsTitle)
                .font(.headline)
                .foregroundColor(.secondary)
                
            Text(Localization.emptyTransactionsSubtitle)
                .font(.subheadline)
                .foregroundColor(.secondary.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
    
    private var floatingActionButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                // Action for the floating button - could be to add a new transaction
                print("Add transaction tapped")
            }
        }) {
            Image(systemName: Localization.Image.addIcon)
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [viewModel.category.name.color, viewModel.category.name.color.opacity(0.8)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .shadow(color: viewModel.category.name.color.opacity(0.4), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(BounceButtonStyle())
    }
    
    private var backButton: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                dismiss()
            }
        }) {
            HStack(spacing: 5) {
                Image(systemName: Localization.Image.backButtonIcon)
                    .font(.title3)
                
                Text(Localization.backButtonTitle)
                    .font(.headline)
            }
            .foregroundColor(viewModel.category.name.color)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .fill(viewModel.category.name.color.opacity(0.15))
            )
        }
        .buttonStyle(BounceButtonStyle())
    }
    
    // MARK: - Helper Views
    
    private func statCard(title: String, value: String, icon: String, iconColor: Color, gradientColors: [Color]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Icon in gradient circle
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .padding(12)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .shadow(color: iconColor.opacity(0.3), radius: 5, x: 0, y: 3)
            
            // Stat info
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            GlassmorphicCard(cornerRadius: 18, cardBackgroundColor: .cardBackgroundColor)
        )
    }
    
    private func transactionCard(transaction: Transaction) -> some View {
        HStack(spacing: 15) {
            // Transaction icon based on description
            Image(systemName: iconForTransaction(transaction))
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorForTransaction(transaction))
                )
            
            // Transaction details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
                
                Text(DateManager().getFormattedDate())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Transaction amount
            Text(transaction.amount.formatCurrency())
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundColor(colorScheme == .dark ? viewModel.category.name.color : viewModel.category.name.color.opacity(0.8))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? 
                      Color(hex: "2A2A40").opacity(0.6) : 
                      Color.white.opacity(0.6))
                .shadow(color: colorScheme == .dark ? .clear : Color.black.opacity(0.05), 
                        radius: 2, x: 0, y: 1)
        )
        .buttonStyle(BounceButtonStyle())
    }
    
    // MARK: - Helper Methods & Properties
    
    private func animateViewsIn() {
        withAnimation(.easeOut.delay(0.1)) {
            headerAppeared = true
        }
        
        withAnimation(.easeOut.delay(0.3)) {
            cardsAppeared = true
        }
        
        withAnimation(.easeOut.delay(0.5)) {
            transactionsAppeared = true
        }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.7)) {
            floatingButtonScale = 1.0
        }
    }
    
    private func iconForTransaction(_ transaction: Transaction) -> String {
        switch transaction.description.lowercased() {
        case let s where s.contains("grocery"):
            return "cart.fill"
        case let s where s.contains("restaurant"):
            return "fork.knife"
        case let s where s.contains("cafe"):
            return "cup.and.saucer.fill"
        case let s where s.contains("clothing"):
            return "tshirt.fill"
        case let s where s.contains("electronics"):
            return "desktopcomputer"
        case let s where s.contains("flight"):
            return "airplane"
        case let s where s.contains("hotel"):
            return "bed.double.fill"
        default:
            return "creditcard.fill"
        }
    }
    
    private func colorForTransaction(_ transaction: Transaction) -> Color {
        switch transaction.description.lowercased() {
        case let s where s.contains("grocery"):
            return Color.green
        case let s where s.contains("restaurant"):
            return Color.orange
        case let s where s.contains("cafe"):
            return Color.brown
        case let s where s.contains("clothing"):
            return Color.blue
        case let s where s.contains("electronics"):
            return Color.indigo
        case let s where s.contains("flight"):
            return Color.purple
        case let s where s.contains("hotel"):
            return Color.pink
        default:
            return viewModel.category.name.color
        }
    }
}

#Preview {
    CategoryDetailView(category: BudgetCategory(name: .food, amountSpent: 300, totalBudget: 400))
}
