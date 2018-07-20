import Foundation

class MetricsBuilder:MetricsBuilderProtocol {
    func build(items:[ScraperItem]) -> Metrics {
        let command:MetricsCommandProtocol = MetricsCommandComposite()
        var stats:Metrics = Metrics()
        for item:ScraperItem in items {
            command.evaluate(item:item)
        }
        command.print(stats:&stats)
        return stats
    }
}
