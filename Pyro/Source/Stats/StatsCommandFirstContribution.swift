import Foundation

class StatsCommandFirstContribution:StatsCommandProtocol {
    private var date:Date!
    
    func evaluate(item:ScraperItem) {
        if self.date == nil {
            let formatter:DateFormatter = DateFormatter()
            formatter.dateFormat = StatsConstants.dateFormat
            self.date = formatter.date(from:item.date)
        }
    }
    
    func print(stats:inout Stats) {
        stats.firstContribution = self.date
    }
}