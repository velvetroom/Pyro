import Foundation
import CleanArchitecture

class StatsPresenter:PresenterProtocol {
    weak var view:ViewProtocol?
    weak var transition:NavigationProtocol?
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
}
