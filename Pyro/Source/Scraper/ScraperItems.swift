import Foundation

struct ScraperItems {
    var checklist:[String:Bool]
    var items:[ScraperItem]
    
    init() {
        self.checklist = [:]
        self.items = []
    }
}
