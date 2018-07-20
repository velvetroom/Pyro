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
        self.viewModel.update(property:self.factory.makeStateLoading())
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
        self.updateState()
        self.updateContent()
    }
    
    func shouldUpdate() {
        self.updateState()
        self.updateContent()
    }
    
    private func updateState() {
        self.viewModel.update(property:self.factory.makeState(user:self.interactor.user))
    }
    
    private func updateContent() {
        if let error:Error = self.interactor.error {
            self.viewModel.update(property:self.factory.makeState(error:error))
        } else if let metrics:Metrics = self.interactor.user.metrics {
            self.viewModel.update(property:self.factory.makeContent(metrics:metrics))
        }
    }
}
