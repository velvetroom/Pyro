import Foundation
import CleanArchitecture

struct StatsStateViewModel:ViewModelProtocol {
    var sync:String
    var message:String
    var metricsHidden:Bool
    var messageHidden:Bool
    var loadingHidden:Bool
    var actionsEnabled:Bool
    var progress:Float
    
    init() {
        self.sync = String()
        self.message = String()
        self.metricsHidden = true
        self.messageHidden = true
        self.loadingHidden = true
        self.actionsEnabled = false
        self.progress = 0
    }
}
