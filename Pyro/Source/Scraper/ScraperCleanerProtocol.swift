import Foundation

protocol ScraperCleanerProtocol {
    func clean(year:Int, items:[ScraperItem]) -> [ScraperItem]
}
