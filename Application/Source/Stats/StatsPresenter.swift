import UIKit
import CleanArchitecture
import Pyro

class StatsPresenter:PresenterProtocol {
    var interactor:StatsInteractor!
    var viewModel:ViewModel!
    
    required init() { }
    
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
        self.interactor.state.update(viewModel:self.viewModel)
    }
    
    func shouldUpdate() {
        self.interactor.state.update(viewModel:self.viewModel)
    }
}
