import Foundation
import CleanArchitecture

struct StatsMonthsViewModel:ViewModelProtocol {
    var items:[Month]
    
    init() {
        self.items = []
    }
}
