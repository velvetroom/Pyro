import UIKit
import Pyro

class Router:UINavigationController {
    init() {
        super.init(nibName:nil, bundle:nil)
        self.configureNavigation()
        self.navigateToUsers()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        if let gesture:UIGestureRecognizer = self.interactivePopGestureRecognizer {
            self.view.removeGestureRecognizer(gesture)
        }
    }
    
    func routeToStats(pyro:Pyro, user:User_v1) {
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
