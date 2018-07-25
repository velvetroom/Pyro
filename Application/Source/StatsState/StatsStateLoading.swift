import Foundation
import CleanArchitecture

class StatsStateLoading:StatsStateProtocol {
    let progress:Float
    
    private var stateProperty:StatsContentViewModel {
        get {
            var property:StatsContentViewModel = StatsContentViewModel()
            property.sync = NSLocalizedString("StatsStateLoading_Sync", comment:String())
            property.metricsHidden = true
            property.messageHidden = true
            property.loadingHidden = false
            property.actionsEnabled = false
            return property
        }
    }
    
    private var loadingProperty:StatsLoadingViewModel {
        get {
            var property:StatsLoadingViewModel = StatsLoadingViewModel()
            property.progress = self.progress
            return property
        }
    }
    
    init(progress:Float) {
        self.progress = progress
    }
    
    func update(viewModels:ViewModels) {
//        viewModel.update(property:self.stateProperty)
//        viewModel.update(property:self.loadingProperty)
    }
}
