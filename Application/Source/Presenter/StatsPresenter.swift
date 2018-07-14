import Foundation
import CleanArchitecture

class StatsPresenter:PresenterProtocol {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func synchronize() {
        self.updateWith(builder:StatsViewModelBuilderLoading())
        self.interactor.synchStats()
    }
    
    func didLoad() {
        self.shouldUpdate()
    }
    
    func shouldUpdate() {
        if let error:Error = self.interactor.error {
            self.updateWith(builder:StatsViewModelBuilderError(error:error))
        } else {
            self.updateWith(builder:StatsViewModelBuilderStats(stats:self.interactor.user.stats))
        }
    }
    
    private func updateWith(builder:StatsViewModelBuilderProtocol) {
        var builder:StatsViewModelBuilderProtocol = builder
        builder.build()
        self.viewModel.update(property:builder.viewModel)
    }
}
