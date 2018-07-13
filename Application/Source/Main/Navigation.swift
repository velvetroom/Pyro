import UIKit
import Pyro

class Navigation:UINavigationController {
    init() {
        super.init(nibName:nil, bundle:nil)
        self.configureNavigation()
        self.navigateToUsers()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    func pushStatsFor(user:User) {
        let view:StatsView = StatsView()
        view.presenter.interactor.user = user
        view.presenter.interactor.transition = self
        self.pushViewController(view, animated:true)
    }
    
    private func configureNavigation() {
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func navigateToUsers() {
        let users:UsersView = UsersView()
        users.presenter.interactor.transition = self
        self.setViewControllers([users], animated:false)
    }
}
