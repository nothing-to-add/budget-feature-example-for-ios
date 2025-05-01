//
//  File name: BudgetServiceMockData.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 30/04/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

struct BudgetServiceMockData {
    
    static let monthlyBudget = BudgetCategory(name: .monthly, amountSpent: 500, totalBudget: 1000)
    
    static let categories: [BudgetCategory] = [
        BudgetCategory(name: .food, amountSpent: 200, totalBudget: 300),
        BudgetCategory(name: .shopping, amountSpent: 150, totalBudget: 200),
        BudgetCategory(name: .travel, amountSpent: 100, totalBudget: 500)
    ]
    
    struct Localization {
        static let groceryStore = "Grocery Store"
        static let restaurant = "Restaurant"
        static let cafe = "Cafe"
        static let clothingStore = "Clothing Store"
        static let electronics = "Electronics"
        static let flightTicket = "Flight Ticket"
        static let hotelBooking = "Hotel Booking"
    }

    static let foodTransactions: [Transaction] = [
        Transaction(description: Localization.groceryStore, amount: 30),
        Transaction(description: Localization.restaurant, amount: 50),
        Transaction(description: Localization.cafe, amount: 20)
    ]
    
    static let shoppingTransactions: [Transaction] = [
        Transaction(description: Localization.clothingStore, amount: 100),
        Transaction(description: Localization.electronics, amount: 200)
    ]
    
    static let travelTransactions: [Transaction] = [
        Transaction(description: Localization.flightTicket, amount: 300),
        Transaction(description: Localization.hotelBooking, amount: 150)
    ]
}
