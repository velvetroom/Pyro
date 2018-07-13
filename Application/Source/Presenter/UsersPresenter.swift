import Foundation
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    var interactor:UserInteractor!
    var viewModel:ViewModel!
    private var factory:UsersViewModelFactory
    
    required init() {
        self.factory = UsersViewModelFactory()
    }
    
    func didAppear() {
        self.interactor.load { [weak self] in
            self?.updateViewModel()
        }
    }
    
    func selectUser(index:IndexPath) {
        self.interactor.selectUser(index:index.item)
    }
    
    func createUser() {
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
        self.viewModel.update(property:self.factory.make(pyro:self.interactor.pyro))
    }
}
