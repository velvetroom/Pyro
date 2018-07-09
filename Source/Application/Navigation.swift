import UIKit

class Navigation:UINavigationController, NavigationProtocol {
    init() {
        super.init(nibName:nil, bundle:nil)
        self.configureNavigation()
        self.navigateToUsers()
    }
    
    required init?(coder:NSCoder) {
        return nil
    }
    
    func openStatsFor(user:User) {
        
    }
    
    private func configureNavigation() {
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.always
        }
    }
    
    private func navigateToUsers() {
        let users:UsersView = UsersView()
        users.transition = self
        self.setViewControllers([users], animated:false)
    }
}
