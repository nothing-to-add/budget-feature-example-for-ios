//
//  File name: SettingsView.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

/// Placeholder for Settings View
struct SettingsView: View {
    @EnvironmentObject private var router: BudgetRouter
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
            
            Button("Go Back") {
                router.goBack()
            }
            .buttonStyle(BounceButtonStyle())
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
