import UIKit
import CleanArchitecture
import Pyro

class UsersPresenter:Presenter {
    var sort:UsersSort
    var interactor:UsersInteractor!
    var viewModels:ViewModels!
    private var factory:UsersFactory
    
    required init() {
        self.sort = UsersSort.name
        self.factory = UsersFactory()
    }
    
    func select(item:UsersItem) {
        self.router(user:item.user)
    }
    
    func createUser() {
        let view:CreateView = CreateView()
        Application.router.pushViewController(view, animated:true)
    }
    
    func willAppear() { self.interactor.updateUsers() }
    
    func shouldUpdate() {
        let viewModel:UsersViewModel
        switch self.sort {
        case UsersSort.name: viewModel = self.factory.byName(pyro:self.interactor.pyro)
        case UsersSort.contributions: viewModel = self.factory.byContributions(pyro:self.interactor.pyro)
        case UsersSort.streak: viewModel = self.factory.byStreak(pyro:self.interactor.pyro)
        }
        self.viewModels.update(viewModel:viewModel)
    }
    
    private func router(user:UserProtocol) {
        let view:StatsView = StatsView()
        view.presenter.interactor.user = user
        Application.router.pushViewController(view, animated:true)
    }
}
