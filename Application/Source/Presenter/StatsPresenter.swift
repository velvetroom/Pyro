import Foundation
import CleanArchitecture
import Pyro

class StatsPresenter:PresenterProtocol {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func didLoad() {
        self.updateViewModel()
    }
    
    func didAppear() {
        self.interactor.generateReport()
    }
    
    func shouldUpdate() {
        self.updateViewModel()
    }
    
    private func updateViewModel() {
        var builder:StatsViewModelBuilderProtocol = self.makeBuilder()
        builder.build()
        self.viewModel.update(property:builder.viewModel)
    }
    
    private func makeBuilder() -> StatsViewModelBuilderProtocol {
        if let error:Error = self.interactor.error {
            return StatsViewModelBuilderError(error:error)
        } else if let stats:Stats = self.interactor.stats {
            return StatsViewModelBuilderReady(stats:stats)
        } else {
            return StatsViewModelBuilderLoading()
        }
    }
}
