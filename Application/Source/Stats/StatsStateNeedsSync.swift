import Foundation
import CleanArchitecture

class StatsStateNeedsSync:StatsStateProtocol {
    func update(viewModels:ViewModels) {
        viewModels.update(viewModel:self.state)
        viewModels.update(viewModel:self.message)
    }
    
    private var state:StatsContentViewModel { get {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.sync = NSLocalizedString("StatsStateNeedsSync.sync", comment:String())
        property.metricsHidden = true
        property.messageHidden = false
        property.loadingHidden = true
        property.actionsEnabled = true
        return property
    } }
    
    private var message:StatsMessageViewModel { get {
        var property:StatsMessageViewModel = StatsMessageViewModel()
        property.message = NSLocalizedString("StatsStateNeedsSync.message", comment:String())
        return property
    } }
}
