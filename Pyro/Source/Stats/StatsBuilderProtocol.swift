import Foundation

protocol StatsBuilderProtocol {
    func build(items:[ScraperItem]) -> Stats
}
