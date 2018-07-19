import Foundation

class MetricsCommandYears:MetricsCommandProtocol {
    private var years:[Year]
    
    init() {
        self.years = []
    }
    
    func evaluate(item:ScraperItem) {
        
    }
    
    func print(stats:inout Metrics) {
        stats.contributions.years = self.years
    }
}
