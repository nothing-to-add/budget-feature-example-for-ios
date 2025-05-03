//
//  File name: GlassmorphicCard.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 02/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

struct GlassmorphicCard: View {
    
    @Environment(\.colorScheme) private var colorScheme
    let cornerRadius: CGFloat
    let cardBackgroundColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(cardBackgroundColor)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Material.ultraThinMaterial)
            )
            .shadow(
                color: colorScheme == .dark ?
                Color.black.opacity(0.3) :
                    Color.black.opacity(0.07),
                radius: 10, x: 0, y: 5
            )
    }
}

#Preview {
    GlassmorphicCard(cornerRadius: 20, cardBackgroundColor: Color.white.opacity(0.85))
}
