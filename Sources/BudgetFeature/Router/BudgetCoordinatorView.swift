//
//  File name: BudgetCoordinatorView.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

/// Coordinator view that handles navigation routing throughout the app
struct BudgetCoordinatorView: View {
    @StateObject private var router = BudgetRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            BudgetOverviewView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .budgetOverview:
                        BudgetOverviewView()
                    case .categoryDetail(let category):
                        CategoryDetailView(category: category)
                    case .settings:
                        SettingsView()
                    case .notifications:
                        NotificationsView()
                    case .addCategory:
                        AddCategoryView()
                    }
                }
        }
        .environmentObject(router)
    }
}
