import Foundation

class StatsCommandFirstContribution:StatsCommandProtocol {
    private var date:Date?
    
    func evaluate(item:ScraperItem) {
        if self.date == nil {
            if item.count > 0 {
                let formatter:DateFormatter = DateFormatter()
                formatter.dateFormat = StatsConstants.dateFormat
                self.date = formatter.date(from:item.date)
            }
        }
    }
    
    func print(stats:inout Stats) {
        if let date:Date = self.date {
            stats.contributions.first = date
        }
    }
}
