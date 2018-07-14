import UIKit
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    var interactor:UserInteractor!
    var viewModel:ViewModel!
    private var factory:UsersViewModelFactory
    
    required init() {
        self.factory = UsersViewModelFactory()
    }
    
    func didAppear() {
        self.interactor.load()
    }
    
    func selectUser(index:IndexPath) {
        self.interactor.selectUser(index:index.item)
    }
    
    func createUser() {
        let alert:UsersViewNew = UsersViewNew(title:nil, message:nil, preferredStyle:UIAlertController.Style.alert)
        alert.presenter = self
        alert.configureView()
        self.interactor.router?.present(alert, animated:true, completion:nil)
    }
    
    func add(name:String, url:String) {
        self.interactor.add(name:name, url:url)
    }
    
    func shouldUpdate() {
        self.viewModel.update(property:self.factory.make(pyro:self.interactor.pyro))
    }
}
