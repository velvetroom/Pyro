import Foundation
import CleanArchitecture

struct StatsViewModel:ViewModelProtocol {
    var items:[StatsItem]
    var actionsEnabled:Bool
    
    init() {
        self.items = []
        self.actionsEnabled = false
    }
}
