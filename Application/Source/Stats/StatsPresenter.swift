import UIKit
import CleanArchitecture
import Pyro

class StatsPresenter:PresenterProtocol {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    private var factory:StatsFactory
    
    required init() {
        self.factory = StatsFactory()
    }
    
    func synchronize() {
        self.interactor.synchStats()
    }
    
    func deleteUser() {
        let alert:DeleteView = DeleteView(title:nil, message:nil, preferredStyle:UIAlertController.Style.alert)
        alert.presenter = self
        alert.configureView()
        self.interactor.router?.present(alert, animated:true, completion:nil)
    }
    
    func confirmDelete() {
        self.interactor.delete()
    }
    
    func select(item:StatsItem) {
        var property:StatsMonthsViewModel = StatsMonthsViewModel()
        property.items = item.months
        self.viewModel.update(property:property)
    }
    
    func didLoad() {
        self.interactor.checkState()
        self.updateViewModel()
    }
    
    func shouldUpdate() {
        self.updateViewModel()
    }
    
    func updateViewModel() {
        self.viewModel.update(property:self.interactor.state.makeViewModel(factory:self.factory))
        self.viewModel.update(property:self.factory.makeContent(state:self.interactor.state))
    }
}
