//
//  File name: ServiceManager.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

struct ServiceManager {
    static let shared = ServiceManager()

    private init() {}
    
    func getBudgetService() -> BudgetServiceProtocol {
        //might be added logic to return real HTTPS service
        return BudgetServiceMock()
    }
}
