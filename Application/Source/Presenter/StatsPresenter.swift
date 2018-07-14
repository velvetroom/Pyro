import Foundation
import CleanArchitecture

class StatsPresenter:PresenterProtocol {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func didLoad() {
        var builder:StatsViewModelBuilderProtocol = StatsViewModelBuilderLoading()
        builder.build()
        self.viewModel.update(property:builder.viewModel)
    }
    
    func shouldUpdate() {
        var builder:StatsViewModelBuilderProtocol
        if let error:Error = self.interactor.error {
            builder = StatsViewModelBuilderError(error:error)
        } else {
            builder = StatsViewModelBuilderReady(stats:self.interactor.user.stats)
        }
        builder.build()
        self.viewModel.update(property:builder.viewModel)
    }
}
