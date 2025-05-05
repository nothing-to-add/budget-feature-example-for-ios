//
//  File name: BudgetOverviewViewModelTests.swift
//  Project name: BudgetFeatureTests
//  Workspace name: budget-feature-example-for-ios
//
//  Created by: nothing-to-add on 05/05/2025
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import XCTest
@testable import BudgetFeature

final class BudgetOverviewViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    private var mockBudgetService: MockBudgetService!
    private var viewModel: BudgetOverviewViewModel!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        // Since MockBudgetService is @MainActor-isolated, we need to initialize it on the main actor
        mockBudgetService = MockBudgetService()
        // viewModel initialization moved to each test method
    }
    
    override func tearDown() {
        mockBudgetService = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Loading Tests
    
    @MainActor
    func testLoadBudgetData_ShouldFetchDataFromService() async {
        // Given
        await setupMonthlyBudgetTestData()
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        XCTAssertTrue(viewModel.isLoading)
        
        // When
        viewModel.loadBudgetData()
        
        // Need to wait for the async task to complete
        await fulfillment(of: [mockBudgetService.fetchMonthlyBudgetCalled, mockBudgetService.fetchCategoriesCalled], timeout: 1.0)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isSpinning)
        XCTAssertEqual(viewModel.monthlyBudget?.totalBudget, 1000.0)
        XCTAssertEqual(viewModel.monthlyBudget?.amountSpent, 750.0)
        XCTAssertEqual(viewModel.categories.count, 2)
    }
    
    @MainActor
    func testLoadingIsAppearing_ShouldSetIsSpinningToTrue() async {
        // Given
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        viewModel.isSpinning = false
        
        // When
        viewModel.loadingIsAppearing()
        
        // Then
        XCTAssertTrue(viewModel.isSpinning)
    }
    
    // MARK: - Budget Calculation Tests
    
    @MainActor
    func testGetRemainingBudget_WhenMonthlyBudgetExists_ShouldCalculateCorrectly() async {
        // Given
        await setupMonthlyBudget(amountSpent: 300.0, totalBudget: 1000.0)
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getRemainingBudget()
        
        // Then
        XCTAssertEqual(result, "€700,00")
    }
    
    @MainActor
    func testGetRemainingBudget_WhenMonthlyBudgetIsNil_ShouldReturnZero() async {
        // Given
        await clearMonthlyBudget()
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getRemainingBudget()
        
        // Then
        XCTAssertEqual(result, "€0,00")
    }
    
    @MainActor
    func testGetPercentageValue_WhenMonthlyBudgetExists_ShouldCalculateCorrectly() async {
        // Given
        await setupMonthlyBudget(amountSpent: 350.0, totalBudget: 1000.0)
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getPercentageValue()
        
        // Then
        XCTAssertEqual(result, 35)
    }
    
    @MainActor
    func testGetPercentageValue_WhenMonthlyBudgetIsNil_ShouldReturnZero() async {
        // Given
        await clearMonthlyBudget()
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        let result = viewModel.getPercentageValue()
        
        // Then
        XCTAssertEqual(result, 0)
    }
    
    @MainActor
    func testGetSpentAmount_WhenMonthlyBudgetExists_ShouldReturnFormattedAmount() async {
        // Given
        await setupMonthlyBudget(amountSpent: 450.0, totalBudget: 1000.0)
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getSpentAmount()
        
        // Then
        XCTAssertEqual(result, "€450,00")
    }
    
    @MainActor
    func testGetSpentAmount_WhenMonthlyBudgetIsNil_ShouldReturnZero() async {
        // Given
        await clearMonthlyBudget()
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getSpentAmount()
        
        // Then
        XCTAssertEqual(result, "€0,00")
    }
    
    @MainActor
    func testGetProgressValue_WhenMonthlyBudgetExists_ShouldCalculateCorrectly() async {
        // Given
        await setupMonthlyBudget(amountSpent: 600.0, totalBudget: 1000.0)
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getProgressValue()
        
        // Then
        XCTAssertEqual(result, 0.6, accuracy: 0.001)
    }
    
    @MainActor
    func testGetProgressValue_WhenAmountExceedsBudget_ShouldReturnOne() async {
        // Given
        await setupMonthlyBudget(amountSpent: 1200.0, totalBudget: 1000.0)
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getProgressValue()
        
        // Then
        XCTAssertEqual(result, 1.0, accuracy: 0.001)
    }
    
    @MainActor
    func testGetProgressValue_WhenMonthlyBudgetIsNil_ShouldReturnZero() async {
        // Given
        await clearMonthlyBudget()
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        let result = viewModel.getProgressValue()
        
        // Then
        XCTAssertEqual(result, 0.0, accuracy: 0.001)
    }
    
    @MainActor
    func testGetTotalBudget_WhenMonthlyBudgetExists_ShouldReturnFormattedTotal() async {
        // Given
        await setupMonthlyBudget(amountSpent: 450.0, totalBudget: 1500.0)
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // Load the data before testing
        await loadDataIfNeeded()
        
        // When
        let result = viewModel.getTotalBudget()
        
        // Then
        XCTAssertEqual(result, "€1 500,00")
    }
    
    @MainActor
    func testGetTotalBudget_WhenMonthlyBudgetIsNil_ShouldReturnZero() async {
        // Given
        await clearMonthlyBudget()
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        
        // When
        await loadDataIfNeeded()
        let result = viewModel.getTotalBudget()
        
        // Then
        XCTAssertEqual(result, "€0,00")
    }
    
    @MainActor
    func testGetCurrentDate_ShouldCallDateManager() {
        // Need to mock DateManager to properly test this, 
        // but for now we'll just verify it returns a non-empty string
        viewModel = BudgetOverviewViewModel(budgetService: mockBudgetService)
        let result = viewModel.getCurrentDate()
        XCTAssertFalse(result.isEmpty)
    }
    
    // MARK: - Helper Methods
    
    @MainActor
    private func loadDataIfNeeded() async {
        viewModel.loadBudgetData()
        await fulfillment(of: [mockBudgetService.fetchMonthlyBudgetCalled], timeout: 1.0)
    }
    
    @MainActor
    private func setupMonthlyBudgetTestData() async {
        mockBudgetService.mockMonthlyBudget = BudgetCategory(
            name: .monthly,
            amountSpent: 750.0,
            totalBudget: 1000.0
        )
        mockBudgetService.mockCategories = [
            BudgetCategory(name: .food, amountSpent: 200.0, totalBudget: 300.0),
            BudgetCategory(name: .shopping, amountSpent: 150.0, totalBudget: 200.0)
        ]
    }
    
    @MainActor
    private func setupMonthlyBudget(amountSpent: Double, totalBudget: Double) async {
        mockBudgetService.mockMonthlyBudget = BudgetCategory(
            name: .monthly,
            amountSpent: amountSpent,
            totalBudget: totalBudget
        )
    }
    
    @MainActor
    private func clearMonthlyBudget() async {
        mockBudgetService.mockMonthlyBudget = BudgetCategory(
            name: .monthly,
            amountSpent: 0,
            totalBudget: 0
        )
    }
}

// MARK: - Mock Budget Service
@MainActor
final class MockBudgetService: BudgetServiceProtocol {
    var mockMonthlyBudget = BudgetCategory(name: .monthly, amountSpent: 0, totalBudget: 0)
    var mockCategories: [BudgetCategory] = []
    var mockTransactions: [Transaction] = []
    
    let fetchMonthlyBudgetCalled = XCTestExpectation(description: "fetchMonthlyBudget called")
    let fetchCategoriesCalled = XCTestExpectation(description: "fetchCategories called")
    let fetchTransactionsCalled = XCTestExpectation(description: "fetchTransactions called")
    
    func fetchMonthlyBudget() async -> BudgetCategory {
        fetchMonthlyBudgetCalled.fulfill()
        return mockMonthlyBudget
    }
    
    func fetchCategories() async -> [BudgetCategory] {
        fetchCategoriesCalled.fulfill()
        return mockCategories
    }
    
    func fetchTransactions(for category: BudgetCategories) async -> [Transaction] {
        fetchTransactionsCalled.fulfill()
        return mockTransactions
    }
}
