import Foundation
import CleanArchitecture

class StatsStateError:StatsStateProtocol {
    let error:Error
    
    private var stateProperty:StatsContentViewModel {
        get {
            var property:StatsContentViewModel = StatsContentViewModel()
            property.sync = NSLocalizedString("StatsStateError_Sync", comment:String())
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
            property.message = error.localizedDescription
            return property
        }
    }
    
    init(error:Error) {
        self.error = error
    }
    
    func update(viewModel:ViewModel) {
        viewModel.update(property:self.stateProperty)
        viewModel.update(property:self.messageProperty)
        viewModel.update(property:StatsLoadingViewModel())
    }
}
