import Foundation
import CleanArchitecture

struct StatsContentViewModel:ViewModelProtocol {
    var streak:String
    var contributions:String
    var actionsEnabled:Bool
    
    init() {
        self.streak = String()
        self.contributions = String()
        self.actionsEnabled = false
    }
}
