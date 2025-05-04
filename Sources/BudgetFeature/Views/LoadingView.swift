//
//  File name: LoadingView.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 04/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

struct LoadingView: View {
    
    let spinnerColor: Color
    let textColor: Color
    var isSpinning: Bool
    var onAppearAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            // Shimmer effect placeholder or spinner
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [spinnerColor.opacity(0.2), spinnerColor]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(width: 60, height: 60)
                .rotationEffect(Angle.degrees(isSpinning ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isSpinning
                )
                .onAppear {
                    if let onAppearAction {
                        onAppearAction()
                    }
                }
            
            Text(Localization.loading)
                .font(.system(.title3, design: .rounded, weight: .medium))
                .foregroundColor(textColor)
        }
    }
}

#Preview {
    LoadingView(spinnerColor: Color(hex: "3B82F6"), textColor: Color(hex: "334155"), isSpinning: true)
}
