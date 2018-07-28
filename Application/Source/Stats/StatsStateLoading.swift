import Foundation
import CleanArchitecture

class StatsStateLoading:StatsStateProtocol {
    private let progress:Float
    
    init(progress:Float) {
        self.progress = progress
    }
    
    func update(viewModels:ViewModels) {
        viewModels.update(viewModel:self.state)
        viewModels.update(viewModel:self.loading)
    }
    
    private var state:StatsContentViewModel { get {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.sync = NSLocalizedString("StatsStateLoading.sync", comment:String())
        property.metricsHidden = true
        property.messageHidden = true
        property.loadingHidden = false
        property.actionsEnabled = false
        return property
    } }
    
    private var loading:StatsLoadingViewModel { get {
        var property:StatsLoadingViewModel = StatsLoadingViewModel()
        property.progress = self.progress
        return property
    } }
}
