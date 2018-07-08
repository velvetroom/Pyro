import Foundation

class PresenterFactory {
    class func makePresenter<Presenter:PresenterProtocol>() -> Presenter {
            let interactor:Presenter.Interactor = Presenter.Interactor()
            let presenter:Presenter = Presenter()
            presenter.interactor = interactor
            interactor.presenter = presenter
            return presenter
    }
    
    private init() { }
}
