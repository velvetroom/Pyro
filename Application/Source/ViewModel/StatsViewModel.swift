import Foundation
import CleanArchitecture

struct StatsViewModel:ViewModelProtocol {
    var items:[StatsViewModelItem]
    var actionsEnabled:Bool
    
    init() {
        self.items = []
        self.actionsEnabled = false
    }
}
