import Foundation
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    weak var view:ViewProtocol?
    weak var transition:NavigationProtocol?
    var interactor:UserInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func didAppear() {
        self.interactor.load { [weak self] (users:[User]) in
            self?.viewModel.update(property:ViewModelFactory.make(users:users))
        }
    }
    
    func selectUser(index:Int) {
        self.transition?.openStatsFor(user:self.interactor.users[index])
    }
}
