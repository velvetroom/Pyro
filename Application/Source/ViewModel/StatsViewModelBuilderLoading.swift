import Foundation

class StatsViewModelBuilderLoading:StatsViewModelBuilderProtocol {
    var viewModel:StatsViewModel
    let status:String
    let firstContribution:String
    let lastContribution:String
    let contributions:String
    let maxStreak:String
    let currentStreak:String
    
    init() {
        let loadingSymbol:String = "..."
        self.viewModel = StatsViewModel()
        self.status = NSLocalizedString("StatsViewModelItem_Loading", comment:String())
        self.firstContribution = loadingSymbol
        self.lastContribution = loadingSymbol
        self.contributions = loadingSymbol
        self.maxStreak = loadingSymbol
        self.currentStreak = loadingSymbol
    }
}
