import Foundation

class MetricsBuilder:MetricsBuilderProtocol {
    private let command:MetricsCommandProtocol
    
    init() {
        self.command = MetricsCommandComposite()
    }
    
    func build(items:[ScraperItem]) -> Metrics {
        var stats:Metrics = Metrics()
        for item:ScraperItem in items {
            self.command.evaluate(item:item)
        }
        self.command.print(stats:&stats)
        return stats
    }
}
