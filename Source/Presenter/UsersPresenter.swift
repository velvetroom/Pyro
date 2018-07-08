import Foundation
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    weak var view:ViewProtocol?
    weak var transition:NavigationProtocol?
    var interactor:Interactor!
    var viewModel:ViewModel!
    
    required init() { }
}
