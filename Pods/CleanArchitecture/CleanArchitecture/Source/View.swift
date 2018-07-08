import UIKit

open class View<Presenter:PresenterProtocol, Content:UIView>:UIViewController, ViewProtocol {
    open var presenter:Presenter
    open var content:Content!
    
    open var transition:Presenter.Transition? {
        get {
            return self.presenter.transition
        }
        set(newValue) {
            self.presenter.transition = newValue
        }
    }
    
    open var interactor:InteractorProtocol {
        get {
            return self.presenter.interactor
        }
    }
    
    open var viewModel:ViewModel {
        get {
            return self.presenter.viewModel
        }
    }
    
    public required init() {
        self.presenter = PresenterFactory.makePresenter()
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
        self.didLoad()
        self.presenter.didLoad()
        self.presenter.interactor.didLoad()
    }
    
    open override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.willAppear()
        self.presenter.willAppear()
    }
    
    open override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.didAppear()
        self.presenter.didAppear()
    }
    
    open override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to:size, with:coordinator)
        self.orientationChanged(size:size)
        self.presenter.orientationChanged()
    }
    
    open func initProperties() { }
    open func didLoad() { }
    open func willAppear() { }
    open func didAppear() { }
    open func orientationChanged(size:CGSize) { }
    
    private func postInit() {
        self.content = Content()
        self.presenter.viewModel = ViewModel()
        self.presenter.view = self
        self.initProperties()
    }
}
