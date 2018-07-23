import Foundation

struct Session_v1:SessionProtocol, Codable {
    var rates:[Date]
    var reports:Int
    
    init() {
        self.rates = []
        self.reports = 0
    }
}
