import Foundation
import CleanArchitecture

struct StatsMetricsViewModel:ViewModel {
    var items:[StatsItem]
    var streak:NSAttributedString
    var contributions:NSAttributedString
    
    init() {
        self.items = []
        self.streak = NSAttributedString()
        self.contributions = NSAttributedString()
    }
}
