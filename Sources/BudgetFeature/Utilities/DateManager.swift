//
//  File name: DateManager.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 03/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

struct DateManager {
    private let dateFormatter = DateFormatter()
    
    private var formattedDate: String {
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: Date())
    }
    
    private var formattedCurrentDate: String {
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: Date())
    }
    
    func getFormattedDate() -> String {
        return formattedDate
    }
    
    func getFormattedCurrentDate() -> String {
        return formattedCurrentDate
    }
}
