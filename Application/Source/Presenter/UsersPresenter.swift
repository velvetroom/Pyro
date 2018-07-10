import Foundation
import CleanArchitecture
import Pyro

class UsersPresenter:PresenterProtocol {
    var interactor:UserInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func didAppear() {
        self.interactor.load { [weak self] (users:[User]) in
            self?.viewModel.update(property:UsersViewModelFactory.make(users:users))
        }
    }
    
    func selectUser(index:Int) {
        self.interactor.transition?.pushStatsFor(user:self.interactor.users[index])
    }
}
