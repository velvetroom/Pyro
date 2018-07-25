import Foundation
import CleanArchitecture

struct StatsMonthsViewModel:ViewModel {
    var items:[StatsItemMonth]
    
    init() {
        self.items = []
    }
}
