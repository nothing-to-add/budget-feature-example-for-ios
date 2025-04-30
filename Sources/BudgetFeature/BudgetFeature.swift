// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct BudgetFeature {
    
    public init() {}

    @MainActor public func makeBudgetView() -> some View {
        BudgetOverviewView()
    }
}
