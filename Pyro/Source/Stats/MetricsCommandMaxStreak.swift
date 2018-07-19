import Foundation

class MetricsCommandMaxStreak:MetricsCommandProtocol {
    private var maxStreak:Int
    private var currentStreak:Int
    
    init() {
        self.maxStreak = 0
        self.currentStreak = 0
    }
    
    func evaluate(item:ScraperItem) {
        if item.count > 0 {
            self.currentStreak += 1
        } else {
            self.maxStreak = max(self.maxStreak, self.currentStreak)
            self.currentStreak = 0
        }
    }
    
    func print(stats:inout Metrics) {
        stats.streak.max = max(self.currentStreak, self.maxStreak)
    }
}
