import Foundation

@MainActor
class CategoryDetailViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = true
    let category: BudgetCategory

    private let budgetService = BudgetService()

    init(category: BudgetCategory) {
        self.category = category
    }

    func loadTransactions() {
        Task {
            isLoading = true
            transactions = await budgetService.fetchTransactions(for: category.name)
            isLoading = false
        }
    }
}
