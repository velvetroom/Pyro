import Foundation

class MetricsCommandContributions:MetricsCommandProtocol {
    private var contributions:Int
    
    init() {
        self.contributions = 0
    }
    
    func evaluate(item:ScraperItem) {
        self.contributions += item.count
    }
    
    func print(stats:inout Metrics) {
        stats.contributions.count = self.contributions
    }
}
