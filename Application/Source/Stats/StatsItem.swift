import Foundation

struct StatsItem {
    var months:[StatsItemMonth]
    var value:Int
    
    init() {
        self.months = []
        self.value = 0
    }
}
