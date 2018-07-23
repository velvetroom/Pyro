import Foundation
import CleanArchitecture

struct StatsMonthsViewModel:ViewModelProtocol {
    var items:[StatsItemMonth]
    
    init() {
        self.items = []
    }
}
