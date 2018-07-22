import Foundation

struct Session:Codable {
    var rates:[Date]
    var reports:Int
    
    init() {
        self.rates = []
        self.reports = 0
    }
}
