import UIKit
import Pyro

class Router:UINavigationController {
    init() {
        super.init(nibName:nil, bundle:nil)
        self.configureNavigation()
        self.navigateToUsers()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    func routeToUsers(pyro:Pyro, user:User) {
        let view:StatsView = StatsView()
        view.presenter.interactor.pyro = pyro
        view.presenter.interactor.user = user
        view.presenter.interactor.router = self
        self.pushViewController(view, animated:true)
    }
    
    private func configureNavigation() {
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.tintColor = UIColor.black
        self.toolbar.barTintColor = UIColor.white
        self.toolbar.tintColor = UIColor.black
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func navigateToUsers() {
        let users:UsersView = UsersView()
        users.presenter.interactor.router = self
        self.setViewControllers([users], animated:false)
    }
}
