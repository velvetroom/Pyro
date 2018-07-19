import Foundation

protocol MetricsCommandProtocol {
    func evaluate(item:ScraperItem)
    func print(stats:inout Metrics)
}
