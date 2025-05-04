import Foundation

@MainActor
class CategoryDetailViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = true
    @Published var isSpinning = false
    let category: BudgetCategory

    private let budgetService = BudgetService.shared

    init(category: BudgetCategory) {
        self.category = category
    }

    func loadTransactions() {
        Task {
            isLoading = true
            transactions = await budgetService.fetchTransactions(for: category.name)
            isLoading = false
            isSpinning = false
        }
    }
    
    func getProgressValue() -> Double {
        min(category.amountSpent / category.totalBudget, 1.0)
    }
    
    func getPercentageProgress() -> Int {
        Int((category.amountSpent / category.totalBudget) * 100)
    }
    
    func getTotalSpent() -> String {
        category.amountSpent.formatCurrency()
    }
    
    func getRemainingBudget() -> String {
        (category.totalBudget - category.amountSpent).formatCurrency()
    }
    
    func getTotalBudget() -> String {
        category.totalBudget.formatCurrency()
    }
}
