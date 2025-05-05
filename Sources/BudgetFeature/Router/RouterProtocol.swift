//
//  File name: RouterProtocol.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

/// Protocol defining the navigation capabilities of the app
protocol RouterProtocol: ObservableObject {
    /// The navigation path containing the current navigation stack
    var path: NavigationPath { get set }
    
    /// Navigate to a specified route
    func navigate(to route: Route)
    
    /// Go back one level in the navigation stack
    func goBack()
    
    /// Go back to the root view
    func goToRoot()
}