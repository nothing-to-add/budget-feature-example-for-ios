//
//  File name: Localization.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 01/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

struct Localization {
    // General
    static let loading = "Loading..."
    static let backButtonTitle = "Back"
    static let addButtonTitle = "Add"

    // Budget Overview
    static let budgetOverviewTitle = "Budget Overview"
    static let spentBudget = "You’ve spent €%.2f of your €%.2f budget"
    static let spentOfTotal = "€%.2f spent of €%.2f"
    static let monthlyBudget = "Monthly Budget"
    static let categories = "Categories"
    static let pieChartTitle = "Budget Categories"
    static let cardSpentTitle = "Spent"
    static let cardBudgetTitle = "Budget"

    // Category Detail
    static let totalSpent = "Total spent:"
    static let remainingBudget = "Remaining:"
    static let transactions = "Transactions"
    static let emptyTransactionsTitle = "No transactions yet"
    static let emptyTransactionsSubtitle = "Transactions will appear here"

    // Transactions
    static let groceryStore = "Grocery Store"
    static let restaurant = "Restaurant"
    static let cafe = "Cafe"
    static let clothingStore = "Clothing Store"
    static let electronics = "Electronics"
    static let flightTicket = "Flight Ticket"
    static let hotelBooking = "Hotel Booking"
    
    struct Image {
        static let notificationIcon = "bell.fill"
        static let settingIcon = "gear"
        
        static let addIcon = "plus"
        static let foodIcon = "fork.knife"
        static let shoppingIcon = "bag.fill"
        static let travelIcon = "airplane"
        static let monthlyIcon = "calendar"
        
        static let totalSpentIcon = "eurosign.circle.fill"
        static let remainingBudgetIcon = "wallet.pass.fill"
        static let transactionListIcon = "list.bullet.rectangle.fill"
        static let emptyTransactionIcon = "tray"
        static let backButtonIcon = "chevron.left"
        static let monthlyBudgetIcon = "chart.line.uptrend.xyaxis.circle.fill"
    }
    
    struct Categories {
        static let foodTitle = "Food"
        static let shoppingTitle = "Shopping"
        static let travelTitle = "Travel"
        static let monthlyTitle = "Monthly"
    }
}
