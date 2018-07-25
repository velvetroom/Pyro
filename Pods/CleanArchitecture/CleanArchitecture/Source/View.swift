import UIKit

open class View<PresenterType:Presenter>:UIViewController {
    open var presenter:PresenterType
    
    public required init() {
        self.presenter = PresenterType()
        self.presenter.interactor = PresenterType.InteractorType()
        self.presenter.interactor.delegate = self.presenter
        super.init(nibName:nil, bundle:nil)
        self.presenter.viewModels = ViewModels()
    }
    
    public init(presenter:PresenterType) {
        self.presenter = presenter
        super.init(nibName:nil, bundle:nil)
        self.presenter.viewModels = ViewModels()
    }
    
    public required init?(coder:NSCoder) { return nil }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad()
        self.presenter.interactor.didLoad()
    }
    
    open override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.presenter.willAppear()
    }
    
    open override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.presenter.didAppear()
    }
}
