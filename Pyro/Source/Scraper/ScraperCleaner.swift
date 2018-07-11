import Foundation

class ScraperCleaner:ScraperCleanerProtocol {
    func clean(year:Int, items:[ScraperItem]) -> [ScraperItem] {
        var clean:[ScraperItem] = []
        let yearString:String = String(year)
        for item in items {
            if item.date.contains(yearString) {
                clean.append(item)
            }
        }
        return clean
    }
}
