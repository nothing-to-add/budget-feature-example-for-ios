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
    
    static let foodTransactions: [Transaction] = [
        Transaction(description: "Grocery Store", amount: 30),
        Transaction(description: "Restaurant", amount: 50),
        Transaction(description: "Cafe", amount: 20)
    ]
    
    static let shoppingTransactions: [Transaction] = [
        Transaction(description: "Clothing Store", amount: 100),
        Transaction(description: "Electronics", amount: 200)
    ]
    
    static let travelTransactions: [Transaction] = [
        Transaction(description: "Flight Ticket", amount: 300),
        Transaction(description: "Hotel Booking", amount: 150)
        ]
}
