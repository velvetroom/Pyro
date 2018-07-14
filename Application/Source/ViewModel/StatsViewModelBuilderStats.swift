import Foundation
import Pyro

class StatsViewModelBuilderStats:StatsViewModelBuilderProtocol {
    var viewModel:StatsViewModel
    let status:String
    let firstContribution:String
    let lastContribution:String
    let contributions:String
    let maxStreak:String
    let currentStreak:String
    
    init(stats:Stats) {
        self.viewModel = StatsViewModel()
        self.viewModel.actionsEnabled = true
        if let timestamp:Date = stats.timestamp {
            let date:DateFormatter = DateFormatter()
            let number:NumberFormatter = NumberFormatter()
            date.dateStyle = DateFormatter.Style.long
            number.numberStyle = NumberFormatter.Style.decimal
            self.status = NSLocalizedString("StatsViewModelItem_LastSynch", comment:String()) +
                date.string(from:timestamp)
            self.firstContribution = date.string(from:stats.contributions.first)
            self.lastContribution = date.string(from:stats.contributions.last)
            self.contributions = number.string(from:NSNumber(value:stats.contributions.count))!
            self.maxStreak = number.string(from:NSNumber(value:stats.streak.max))!
            self.currentStreak = number.string(from:NSNumber(value:stats.streak.current))!
        } else {
            let emptySymbol:String = "-"
            self.status = NSLocalizedString("StatsViewModelItem_NeverLoaded", comment:String())
            self.firstContribution = emptySymbol
            self.lastContribution = emptySymbol
            self.contributions = emptySymbol
            self.maxStreak = emptySymbol
            self.currentStreak = emptySymbol
        }
    }
}
