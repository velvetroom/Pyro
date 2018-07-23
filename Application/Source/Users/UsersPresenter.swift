import UIKit
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    var sort:UsersSort
    var interactor:UsersInteractor!
    var viewModel:ViewModel!
    private var factory:UsersFactory
    
    required init() {
        self.sort = UsersSort.name
        self.factory = UsersFactory()
    }
    
    func select(item:UsersItem) {
        self.interactor.select(user:item.user)
    }
    
    func createUser() {
        let alert:CreateView = CreateView(title:nil, message:nil, preferredStyle:UIAlertController.Style.alert)
        alert.presenter = self
        alert.configureView()
        self.interactor.router?.present(alert, animated:true, completion:nil)
    }
    
    func add(name:String, url:String) {
        self.interactor.add(name:name, url:url)
    }
    
    func willAppear() {
        self.interactor.load()
    }
    
    func shouldUpdate() {
        let viewModel:UsersViewModel
        switch self.sort {
        case UsersSort.name: viewModel = self.factory.byName(pyro:self.interactor.pyro)
        case UsersSort.contributions: viewModel = self.factory.byContributions(pyro:self.interactor.pyro)
        case UsersSort.streak: viewModel = self.factory.byStreak(pyro:self.interactor.pyro)
        }
        self.viewModel.update(property:viewModel)
    }
}
