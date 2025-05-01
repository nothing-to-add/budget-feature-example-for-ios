//
//  File name: ProgressBar.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 02/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

struct ProgressBar: View {
    var value: Double
    var backgroundColor: Color
    var foregroundColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 8)
                    .fill(backgroundColor)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Foreground
                RoundedRectangle(cornerRadius: 8)
                    .fill(foregroundColor)
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
            }
        }
    }
}

#Preview {
    ProgressBar(value: min(100/200, 1), backgroundColor: .secondary, foregroundColor: .primary)
}
