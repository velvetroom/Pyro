import Foundation

public protocol PresenterProtocol:InteractorDelegate {
    associatedtype Interactor:InteractorProtocol
    var interactor:Interactor! { get set }
    var viewModel:ViewModel! { get set }
    
    init()
    func didLoad()
    func willAppear()
    func didAppear()
}

public extension PresenterProtocol {
    func didLoad() { }
    func willAppear() { }
    func didAppear() { }
    func shouldUpdate() { }
}

public protocol InteractorDelegate:AnyObject {
    func shouldUpdate()
}
