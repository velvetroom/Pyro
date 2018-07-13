import Foundation
import CleanArchitecture

struct StatsViewModel:ViewModelProtocol {
    var items:[StatsViewModelItem]
    
    init() {
        self.items = []
    }
}
