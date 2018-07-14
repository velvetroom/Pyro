import Foundation

class StatsCommandLastContribution:StatsCommandProtocol {
    private var date:String?
    
    func evaluate(item:ScraperItem) {
        if item.count > 0 {
            self.date = item.date
        }
    }
    
    func print(stats:inout Stats) {
        if let date:String = self.date {
            let formatter:DateFormatter = DateFormatter()
            formatter.dateFormat = StatsConstants.dateFormat
            stats.contributions.last = formatter.date(from:date)!
        }
    }
}
