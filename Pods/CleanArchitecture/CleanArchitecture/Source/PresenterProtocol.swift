import Foundation

public protocol PresenterProtocol:InteractorDelegateProtocol {
    associatedtype Interactor:InteractorProtocol
    associatedtype Transition
    var transition:Transition? { get set }
    var view:ViewProtocol? { get set }
    var interactor:Interactor! { get set }
    var viewModel:ViewModel! { get set }
    
    init()
    func didLoad()
    func willAppear()
    func didAppear()
    func orientationChanged()
}
