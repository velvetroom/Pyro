import UIKit
import CleanArchitecture

class UsersPresenter:PresenterProtocol {
    var sort:UsersPresenterSort
    var interactor:UserInteractor!
    var viewModel:ViewModel!
    private var factory:UsersViewModelFactory
    
    required init() {
        self.sort = UsersPresenterSort.name
        self.factory = UsersViewModelFactory()
    }
    
    func select(item:UsersViewModelItem) {
        self.interactor.select(user:item.user)
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
    
    func sortByName() {
        
    }
    
    func sortByContributions() {
        
    }
    
    func sortByStreak() {
        
    }
    
    func didAppear() {
        self.interactor.load()
    }
    
    func shouldUpdate() {
        let viewModel:UsersViewModel
        switch self.sort {
        case UsersPresenterSort.name: viewModel = self.factory.byName(pyro:self.interactor.pyro)
        case UsersPresenterSort.contributions: viewModel = self.factory.byContributions(pyro:self.interactor.pyro)
        case UsersPresenterSort.streak: viewModel = self.factory.byStreak(pyro:self.interactor.pyro)
        }
        self.viewModel.update(property:viewModel)
    }
}
