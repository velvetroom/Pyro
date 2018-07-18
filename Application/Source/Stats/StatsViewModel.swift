import Foundation
import CleanArchitecture

struct StatsViewModel:ViewModelProtocol {
    var actionsEnabled:Bool
    
    init() {
        self.actionsEnabled = false
    }
}
