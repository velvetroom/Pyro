import Foundation

class StatsCommandComposite:StatsCommandProtocol {
    private let commands:[StatsCommandProtocol]
    
    init() {
        self.commands = [
            StatsCommandFirstContribution(),
            StatsCommandLastContribution(),
            StatsCommandContributions(),
            StatsCommandMaxStreak(),
            StatsCommandCurrentStreak()]
    }
    
    func evaluate(item:ScraperItem) {
        for command:StatsCommandProtocol in self.commands {
            command.evaluate(item:item)
        }
    }
    
    func print(stats:inout Stats) {
        for command:StatsCommandProtocol in self.commands {
            command.print(stats:&stats)
        }
    }
}
