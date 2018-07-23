import Foundation
import CleanArchitecture

class StatsStateNeedsSync:StatsStateProtocol {
    private var stateProperty:StatsContentViewModel {
        get {
            var property:StatsContentViewModel = StatsContentViewModel()
            property.sync = NSLocalizedString("StatsStateNeedsSync_Sync", comment:String())
            property.metricsHidden = true
            property.messageHidden = false
            property.loadingHidden = true
            property.actionsEnabled = true
            return property
        }
    }
    
    private var messageProperty:StatsMessageViewModel {
        get {
            var property:StatsMessageViewModel = StatsMessageViewModel()
            property.message = NSLocalizedString("StatsStateNeedsSync_Message", comment:String())
            return property
        }
    }
    
    func update(viewModel:ViewModel) {
        viewModel.update(property:self.stateProperty)
        viewModel.update(property:self.messageProperty)
    }
}
