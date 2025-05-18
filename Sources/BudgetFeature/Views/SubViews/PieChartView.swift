//
//  File name: PieChartView.swift
//  Project name: BudgetFeature
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 01/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI
import Charts

struct PieChartView: View {
    let data: [ChartDataEntry]
    let title: String
    
    var chartColor: Color = .blue
    var titleColor: Color = .primary
    var animationDuration: Double = 1.0
    
    // Calculate the total value of all entries
    private var totalValue: Double {
        data.reduce(0) { $0 + $1.value }
    }
    
    var body: some View {
        VStack(spacing: Constants.Spacing.large) {
            chartTitle
            
            pieChart
            
            // Custom fully visible legend with wrapping
            pieLegend
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
    
    private var chartTitle: some View {
        Text(title)
            .font(.title2.bold())
            .foregroundStyle(titleColor)
            .padding(.bottom, Constants.Padding.small)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var pieChart: some View {
        Chart(data) { entry in
            SectorMark(
                angle: .value("Value", entry.value),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(by: .value("Label", entry.label))
            .cornerRadius(4)
            .annotation(position: .overlay) {
                Text("\(Int(percentageFor(entry: entry)))%")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 0)
            }
        }
        .chartLegend(.hidden)
        .frame(height: 300)
    }
    
    private var pieLegend: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 150, maximum: 200), spacing: Constants.Spacing.large)
            ], spacing: 0) {
                ForEach(data) { entry in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(colorForEntry(entry))
                            .frame(width: 16, height: 16)
                        
                        Text(entry.label)
                            .font(.title3.bold())
                            .foregroundColor(.primary)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, Constants.Padding.small)
                    .padding(.horizontal, Constants.Padding.medium)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemBackground).opacity(0.6))
                    )
                }
            }
        }
        .padding(.horizontal, Constants.Padding.small)
    }
}

private extension PieChartView {
    
    // Calculate percentage for each entry
    func percentageFor(entry: ChartDataEntry) -> Double {
        guard totalValue > 0 else { return 0 }
        return (entry.value / totalValue) * 100
    }
    
    // Color mapping function for our custom legend
    func colorForEntry(_ entry: ChartDataEntry) -> Color {
        // If the entry has a custom color, use it
        if let color = entry.color {
            return color
        }
        
        // Otherwise use a color based on the entry's position in the data array
        if let index = data.firstIndex(where: { $0.id == entry.id }) {
            let colors: [Color] = [.blue, .green, .orange, .red, .purple, .pink, .yellow, .cyan]
            return colors[index % colors.count]
        }
        
        return .blue // Default fallback
    }
}

// MARK: - Preview
#Preview {
    let sampleData = [
        ChartDataEntry(value: 25, label: "Housing"),
        ChartDataEntry(value: 15, label: "Food"),
        ChartDataEntry(value: 10, label: "Transport"),
        ChartDataEntry(value: 8, label: "Entertainment"),
        ChartDataEntry(value: 12, label: "Savings")
    ]
    
    PieChartView(data: sampleData, title: "Monthly Budget")
        .padding()
        .preferredColorScheme(.light)
}

#Preview {
    let sampleData = [
        ChartDataEntry(value: 25, label: "Housing"),
        ChartDataEntry(value: 15, label: "Food"),
        ChartDataEntry(value: 10, label: "Transport"),
        ChartDataEntry(value: 8, label: "Entertainment"),
        ChartDataEntry(value: 12, label: "Savings")
    ]
    
    PieChartView(data: sampleData, title: "Monthly Budget")
        .padding()
        .preferredColorScheme(.dark)
}
