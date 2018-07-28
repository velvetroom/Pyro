import UIKit

struct StatsItem {
    var months:[StatsItemMonth]
    var value:Int
    
    init() {
        self.months = []
        self.value = 0
    }
}

struct StatsItemMonth {
    var ratio:CGFloat
    var contributions:NSAttributedString
    
    init() {
        self.ratio = 0
        self.contributions = NSAttributedString()
    }
}
