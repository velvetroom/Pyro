import Foundation

class StatsBuilder {
    var items:[ScraperItem]
    var stats:Stats
    private let command:StatsCommandProtocol
    
    init() {
        self.items = []
        self.stats = Stats()
        self.command = StatsCommandComposite()
    }
    
    func build() {
        for item:ScraperItem in self.items {
            self.command.evaluate(item:item)
        }
        self.command.print(stats:&self.stats)
    }
}
