import Foundation
import CleanArchitecture

class StatsPresenter:PresenterProtocol {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
}
