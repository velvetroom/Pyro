import Foundation

class StatsViewModelBuilderError:StatsViewModelBuilderProtocol {
    var viewModel:StatsViewModel
    let status:String
    let firstContribution:String
    let lastContribution:String
    let contributions:String
    let maxStreak:String
    let currentStreak:String
    
    init(error:Error) {
        self.viewModel = StatsViewModel()
        let string:String = NSLocalizedString("StatsViewModelItem_Error", comment:String())
        self.status = error.localizedDescription
        self.firstContribution = string
        self.lastContribution = string
        self.contributions = string
        self.maxStreak = string
        self.currentStreak = string
    }
}
