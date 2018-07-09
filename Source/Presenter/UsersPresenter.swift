import Foundation
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    weak var view:ViewProtocol?
    weak var transition:NavigationProtocol?
    var interactor:Interactor!
    var viewModel:ViewModel!
    var users:[User]
    
    required init() {
        self.users = []
    }
    
    func didAppear() {
        self.interactor.load { [weak self] (users:[User]) in
            self?.users = users
            self?.viewModel.update(property:ViewModelFactory.make(users:users))
        }
    }
}
