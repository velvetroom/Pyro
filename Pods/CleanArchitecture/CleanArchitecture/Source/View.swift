import UIKit

open class View<Presenter:PresenterProtocol, Content:UIView>:UIViewController {
    open var presenter:Presenter
    open var content:Content!
    
    public required init() {
        self.presenter = Presenter()
        self.presenter.interactor = Presenter.Interactor()
        self.presenter.interactor.presenter = self.presenter
        super.init(nibName:nil, bundle:nil)
        self.postInit()
    }
    
    public init(presenter:Presenter) {
        self.presenter = presenter
        super.init(nibName:nil, bundle:nil)
        self.postInit()
    }
    
    public required init?(coder:NSCoder) {
        return nil
    }
    
    open override func loadView() {
        self.view = self.content
    }
    
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
    
    open override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to:size, with:coordinator)
        self.presenter.orientationChanged()
    }
    
    private func postInit() {
        self.content = Content()
        self.presenter.viewModel = ViewModel()
    }
}
