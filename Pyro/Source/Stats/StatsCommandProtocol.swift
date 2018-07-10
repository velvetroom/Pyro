import Foundation

protocol StatsCommandProtocol {
    func evaluate(item:ScraperItem)
    func print(stats:inout Stats)
}
