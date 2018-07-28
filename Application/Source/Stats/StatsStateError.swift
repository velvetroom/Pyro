import Foundation
import CleanArchitecture

class StatsStateError:StatsStateProtocol {
    private let error:Error
    
    private var state:StatsContentViewModel { get {
        var property:StatsContentViewModel = StatsContentViewModel()
        property.sync = NSLocalizedString("StatsStateError.sync", comment:String())
        property.metricsHidden = true
        property.messageHidden = false
        property.loadingHidden = true
        property.actionsEnabled = true
        return property
    } }
    
    private var message:StatsMessageViewModel { get {
        var property:StatsMessageViewModel = StatsMessageViewModel()
        property.message = error.localizedDescription
        return property
    } }
    
    init(error:Error) {
        self.error = error
    }
    
    func update(viewModels:ViewModels) {
        viewModels.update(viewModel:self.state)
        viewModels.update(viewModel:self.message)
        viewModels.update(viewModel:StatsLoadingViewModel())
    }
}
