import Foundation

class MetricsCommandContributions:MetricsCommandProtocol {
    private var contributions:Int
    private var max:Int
    
    init() {
        self.contributions = 0
        self.max = 0
    }
    
    func evaluate(item:ScraperItem) {
        self.contributions += item.count
        if item.count > self.max {
            self.max = item.count
        }
    }
    
    func print(stats:inout Metrics) {
        stats.contributions.count = self.contributions
        stats.contributions.max.day = self.max
    }
}
