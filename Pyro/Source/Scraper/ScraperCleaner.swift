import Foundation

class ScraperCleaner {
    var items:[ScraperItem]
    
    init() {
        self.items = []
    }
    
    func cleanOnlyFor(year:String) {
        var items:[ScraperItem] = []
        for item in self.items {
            if item.date.contains(year) {
                items.append(item)
            }
        }
        self.items = items
    }
}
