import Foundation

class StatsCommandContributions:StatsCommandProtocol {
    private var contributions:Int
    
    init() {
        self.contributions = 0
    }
    
    func evaluate(item:ScraperItem) {
        self.contributions += item.count
    }
    
    func print(stats:inout Stats) {
        stats.contributions = self.contributions
    }
}
