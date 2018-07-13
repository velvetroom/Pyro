import Foundation

class StatsBuilder:StatsBuilderProtocol {
    private let command:StatsCommandProtocol
    
    init() {
        self.command = StatsCommandComposite()
    }
    
    func build(items:[ScraperItem]) -> Stats {
        var stats:Stats = Stats()
        for item:ScraperItem in items {
            self.command.evaluate(item:item)
        }
        self.command.print(stats:&stats)
        return stats
    }
}
