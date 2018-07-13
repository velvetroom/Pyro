import Foundation
import CleanArchitecture
import Pyro

class StatsPresenter:PresenterProtocol, ReportDelegate {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func didLoad() {
        var builder:StatsViewModelBuilderProtocol = StatsViewModelBuilderLoading()
        builder.build()
        self.viewModel.update(property:builder.viewModel)
    }
    
    func didAppear() {
        self.interactor.generateReport(delegate:self)
    }
    
    func reportCompleted(stats:Stats) {
        var builder:StatsViewModelBuilderProtocol = StatsViewModelBuilderReady(stats:stats)
        builder.build()
        self.viewModel.update(property:builder.viewModel)
    }
    
    func reportFailed(error:Error) {
        var builder:StatsViewModelBuilderProtocol = StatsViewModelBuilderError(error:error)
        builder.build()
        self.viewModel.update(property:builder.viewModel)
    }
}
