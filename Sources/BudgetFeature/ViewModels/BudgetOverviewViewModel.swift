import Foundation

@MainActor
class BudgetOverviewViewModel: ObservableObject {
    @Published var monthlyBudget: (spent: Double, total: Double)? = nil
    @Published var categories: [BudgetCategory] = []
    @Published var isLoading = true

    private let budgetService = BudgetService()

    func loadBudgetData() {
        Task {
            isLoading = true
            monthlyBudget = await budgetService.fetchMonthlyBudget()
            categories = await budgetService.fetchCategories()
            isLoading = false
        }
    }
}
