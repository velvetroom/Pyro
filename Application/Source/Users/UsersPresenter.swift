import UIKit
import CleanArchitecture
import Pyro

class UsersPresenter:Presenter {
    var selectedSort:Int
    var interactor:UsersInteractor!
    var viewModels:ViewModels!
    private let numberFormatter:NumberFormatter
    private let unknown:String
    
    required init() {
        self.selectedSort = 0
        self.numberFormatter = NumberFormatter()
        self.unknown = NSLocalizedString("UsersPresenter.unknown", comment:String())
        self.numberFormatter.numberStyle = NumberFormatter.Style.decimal
        self.numberFormatter.groupingSeparator = NSLocalizedString("Grouping.separator", comment:String())
    }
    
    func select(item:UsersItem) {
        self.router(user:item.user)
    }
    
    func createUser() {
        let view:CreateView = CreateView()
        view.presenter.interactor.pyro = self.interactor.pyro
        Application.router.pushViewController(view, animated:true)
    }
    
    func shouldUpdate() {
        if self.selectedSort == 0 {
            self.update(users:self.interactor.pyro.users)
        } else {
            self.update(users:self.usersByStreak(users:self.interactor.pyro.users))
        }
    }
    
    func didAppear() { self.interactor.updateUsers() }
    
    private func router(user:UserProtocol) {
        let view:StatsView = StatsView()
        view.presenter.interactor.pyro = self.interactor.pyro
        view.presenter.interactor.user = user
        Application.router.pushViewController(view, animated:true)
    }
    
    private func update(users:[UserProtocol]) {
        var viewModel:UsersViewModel = UsersViewModel()
        for user:UserProtocol in users {
            var item:UsersItem = UsersItem()
            item.name = self.makeName(user:user)
            item.user = user
            item.avatar = user.user
            if let metrics:Metrics = user.metrics {
                item.value = self.numberFormatter.string(from:NSNumber(value:metrics.streak.max))!
            } else {
                item.value = self.unknown
            }
            viewModel.users.append(item)
        }
        self.viewModels.update(viewModel:viewModel)
    }
    
    private func makeName(user:UserProtocol) -> NSAttributedString {
        let string:NSMutableAttributedString = NSMutableAttributedString()
        let name:NSAttributedString = NSAttributedString(string:user.name, attributes:[NSAttributedString.Key.font:
            UIFont.systemFont(ofSize:Constants.title, weight:UIFont.Weight.regular)])
        let url:NSAttributedString = NSAttributedString(string:"\n\(user.url)",
            attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize:Constants.subtitle,
                                                                      weight:UIFont.Weight.ultraLight)])
        string.append(name)
        string.append(url)
        return string
    }
    
    private func usersByStreak(users:[UserProtocol]) -> [UserProtocol] {
        return users.sorted { (userA:UserProtocol, userB:UserProtocol) -> Bool in
            if let metricsA:Metrics = userA.metrics {
                if let metricsB:Metrics = userB.metrics {
                    return metricsA.streak.max > metricsB.streak.max
                } else {
                    return true
                }
            } else {
                return false
            }
        }
    }
}

private struct Constants {
    static let title:CGFloat = 16
    static let subtitle:CGFloat = 12
}
