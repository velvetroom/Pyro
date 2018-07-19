import Foundation
import CleanArchitecture

struct StatsStateViewModel:ViewModelProtocol {
    var sync:String
    var metricsHidden:Bool
    var needsSynchHidden:Bool
    var loadingHidden:Bool
    var actionsEnabled:Bool
    
    init() {
        self.sync = String()
        self.metricsHidden = true
        self.needsSynchHidden = true
        self.loadingHidden = true
        self.actionsEnabled = false
    }
}
