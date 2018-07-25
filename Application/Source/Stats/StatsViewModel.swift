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

struct StatsMessageViewModel:ViewModel {
    var message:String
    
    init() {
        self.message = String()
    }
}

struct StatsMetricsViewModel:ViewModel {
    var items:[StatsItem]
    var streak:NSAttributedString
    var contributions:NSAttributedString
    
    init() {
        self.items = []
        self.streak = NSAttributedString()
        self.contributions = NSAttributedString()
    }
}

struct StatsMonthsViewModel:ViewModel {
    var items:[StatsItemMonth]
    
    init() {
        self.items = []
    }
}

struct StatsLoadingViewModel:ViewModel {
    var progress:Float
    
    init() {
        self.progress = 0
    }
}
