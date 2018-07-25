import Foundation
import CleanArchitecture

struct StatsContentViewModel:ViewModel {
    var sync:String
    var metricsHidden:Bool
    var messageHidden:Bool
    var loadingHidden:Bool
    var actionsEnabled:Bool
    
    init() {
        self.sync = String()
        self.metricsHidden = true
        self.messageHidden = true
        self.loadingHidden = true
        self.actionsEnabled = false
    }
}
