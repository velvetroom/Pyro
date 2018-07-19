import Foundation

protocol MetricsBuilderProtocol {
    func build(items:[ScraperItem]) -> Metrics
}
