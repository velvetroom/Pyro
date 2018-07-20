import Foundation

class MetricsCommandLastContribution:MetricsCommandProtocol {
    private var date:String?
    
    func evaluate(item:ScraperItem) {
        if item.count > 0 {
            self.date = item.date
        }
    }
    
    func print(stats:inout Metrics) {
        if let date:String = self.date {
            let formatter:DateFormatter = DateFormatter()
            formatter.dateFormat = MetricsConstants.dateFormat
            stats.contributions.last = formatter.date(from:date)!
        }
    }
}
