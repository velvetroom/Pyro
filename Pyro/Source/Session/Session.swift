import Foundation

struct Session:Codable {
    var reports:Int
    
    init() {
        self.reports = 0
    }
}
