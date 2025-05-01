//
//  File name: ChartDataEntry.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 02/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation
import SwiftUI

struct ChartDataEntry: Identifiable {
    let id = UUID()
    let value: Double
    let label: String
    var color: Color? = nil  // Optional custom color
}
