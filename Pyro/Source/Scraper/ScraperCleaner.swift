import Foundation

class ScraperCleaner {
    var items:[ScraperItem]
    
    init() {
        self.items = []
    }
    
    func cleanOnlyFor(year:Int) {
        var items:[ScraperItem] = []
        let yearString:String = String(year)
        for item in self.items {
            if item.date.contains(yearString) {
                items.append(item)
            }
        }
        self.items = items
    }
}
