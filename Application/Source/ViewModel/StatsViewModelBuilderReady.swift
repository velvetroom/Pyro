import Foundation
import Pyro

class StatsViewModelBuilderReady:StatsViewModelBuilderProtocol {
    var viewModel:StatsViewModel
    let status:String
    let firstContribution:String
    let lastContribution:String
    let contributions:String
    let maxStreak:String
    let currentStreak:String
    
    init(stats:Stats) {
        let date:DateFormatter = DateFormatter()
        let number:NumberFormatter = NumberFormatter()
        date.dateStyle = DateFormatter.Style.long
        number.numberStyle = NumberFormatter.Style.decimal
        self.viewModel = StatsViewModel()
        self.status = NSLocalizedString("StatsViewModelItem_Ready", comment:String())
        self.firstContribution = date.string(from:stats.firstContribution)
        self.lastContribution = date.string(from:stats.lastContribution)
        self.contributions = number.string(from:NSNumber(value:stats.contributions))!
        self.maxStreak = number.string(from:NSNumber(value:stats.maxStreak))!
        self.currentStreak = number.string(from:NSNumber(value:stats.currentStreak))!
    }
}
