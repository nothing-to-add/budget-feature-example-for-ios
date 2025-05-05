//
//  File name: BudgetFeature.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

/// Main entry point for the Budget Feature
public struct BudgetFeature: View {
    public init() {}
    
    public var body: some View {
        BudgetCoordinatorView()
    }
}

/// Make the feature preview-compatible
#Preview {
    BudgetFeature()
}
