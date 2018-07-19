import Foundation

class MetricsCommandComposite:MetricsCommandProtocol {
    private let commands:[MetricsCommandProtocol]
    
    init() {
        self.commands = [
            MetricsCommandFirstContribution(),
            MetricsCommandLastContribution(),
            MetricsCommandContributions(),
            MetricsCommandMaxStreak(),
            MetricsCommandCurrentStreak()]
    }
    
    func evaluate(item:ScraperItem) {
        for command:MetricsCommandProtocol in self.commands {
            command.evaluate(item:item)
        }
    }
    
    func print(stats:inout Metrics) {
        for command:MetricsCommandProtocol in self.commands {
            command.print(stats:&stats)
        }
    }
}
