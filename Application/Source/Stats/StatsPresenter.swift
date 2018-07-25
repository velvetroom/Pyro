import UIKit
import CleanArchitecture
import Pyro

class StatsPresenter:Presenter {
    var interactor:StatsInteractor!
    var viewModels:ViewModels!
    
    required init() { }
    
    func synchronize() {
        self.interactor.synchStats()
    }
    
    func deleteUser() {
        let alert:DeleteView = DeleteView(title:nil, message:nil, preferredStyle:UIAlertController.Style.alert)
        alert.presenter = self
        alert.configureView()
//        self.interactor.router?.present(alert, animated:true, completion:nil)
    }
    
    func confirmDelete() {
        self.interactor.delete()
    }
    
    func select(item:StatsItem) {
//        var viewModel:StatsMonthsViewModel = StatsMonthsViewModel()
//        viewModel.items = item.months
//        self.viewModels.update(viewModel:viewModel)
    }
    
    func didLoad() {
//        self.interactor.checkState()
//        self.interactor.state.update(viewModel:self.viewModels)
    }
    
    func shouldUpdate() {
//        self.interactor.state.update(viewModel:self.viewModels)
    }
}
