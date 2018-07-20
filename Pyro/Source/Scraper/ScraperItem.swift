import Foundation

struct ScraperItem {
    var date:String
    var count:Int
    var year:Int
    var month:Int
    
    init() {
        self.date = String()
        self.count = 0
        self.year = 0
        self.month = 0
    }
}
