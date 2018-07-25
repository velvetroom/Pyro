import UIKit

@UIApplicationMain class Application:UIResponder, UIApplicationDelegate {
    static var router:Router!
    var window:UIWindow?
    
    func application(_:UIApplication, didFinishLaunchingWithOptions:[UIApplication.LaunchOptionsKey:Any]?) -> Bool {
        Application.router = Router()
        let window:UIWindow = UIWindow(frame:UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        window.rootViewController = Application.router
        self.window = window
        return true
    }
}

class Router:UINavigationController {
    fileprivate init() {
        super.init(nibName:nil, bundle:nil)
        self.configureNavigation()
        self.setViewControllers([UsersView()], animated:false)
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        if let gesture:UIGestureRecognizer = self.interactivePopGestureRecognizer {
            self.view.removeGestureRecognizer(gesture)
        }
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
}
