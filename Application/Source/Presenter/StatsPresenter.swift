import Foundation
import CleanArchitecture

class StatsPresenter:PresenterProtocol {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func didLoad() {
        var viewModelBuilder:StatsViewModelBuilderLoading = StatsViewModelBuilderLoading()
        viewModelBuilder.build()
        self.viewModel.update(property:viewModelBuilder.viewModel)
    }
}
