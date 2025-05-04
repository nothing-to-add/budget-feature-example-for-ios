import Foundation

@MainActor
class BudgetOverviewViewModel: ObservableObject {
    @Published var monthlyBudget: BudgetCategory? = nil
    @Published var categories: [BudgetCategory] = []
    @Published var isLoading = true
    @Published var isSpinning = false

    private let budgetService = BudgetService.shared

    init() {}

    func loadBudgetData() {
        Task {
            isLoading = true
            monthlyBudget = await budgetService.fetchMonthlyBudget()
            categories = await budgetService.fetchCategories()
            isLoading = false
            isSpinning = false
        }
    }
    
    func loadingIsAppearing() {
        isSpinning = true
    }
    
    func getCurrentDate() -> String {
        DateManager().getFormattedCurrentDate()
    }
}
