import Foundation

class MetricsCommandCurrentStreak:MetricsCommandProtocol {
    private var streak:Int
    
    init() {
        self.streak = 0
    }
    
    func evaluate(item:ScraperItem) {
        if item.count > 0 {
            self.streak += 1
        } else {
            self.streak = 0
        }
    }
    
    func print(stats:inout Metrics) {
        stats.streak.current = self.streak
    }
}
