import UIKit
import CleanArchitecture

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
    
    func select(year:Year) {
        var property:StatsMonthsViewModel = StatsMonthsViewModel()
        property.items = year.months
        self.viewModel.update(property:property)
    }
    
    func didLoad() {
//        self.viewModel.update(property:self.factory.makeContent(stats:self.interactor.user.stats))
    }
    
    func didAppear() {
//        self.viewModel.update(property:self.factory.makeYears(stats:self.interactor.user.stats))
    }
}
