import Foundation
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    var interactor:UserInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
    func didAppear() {
        self.interactor.load { [weak self] in
            self?.updateViewModel()
        }
    }
    
    func selectUser(index:Int) {
        self.interactor.transition?.pushStatsFor(user:self.interactor.users[index])
    }
    
    func addNew() {
        let alert:UsersViewNew = UsersViewNew(title:nil, message:nil, preferredStyle:UIAlertController.Style.alert)
        alert.presenter = self
        alert.configureView()
        self.interactor.transition?.present(alert, animated:true, completion:nil)
    }
    
    func add(name:String, url:String) {
        self.interactor.add(name:name, url:url)
        self.updateViewModel()
    }
    
    private func updateViewModel() {
        self.viewModel.update(property:UsersViewModelFactory.make(users:self.interactor.users))
    }
}
