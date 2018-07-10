import Foundation

class StatsCommandLastContribution:StatsCommandProtocol {
    private var date:String!
    
    func evaluate(item:ScraperItem) {
        self.date = item.date
    }
    
    func print(stats:inout Stats) {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = StatsConstants.dateFormat
        stats.lastContribution = formatter.date(from:self.date)!
    }
}
