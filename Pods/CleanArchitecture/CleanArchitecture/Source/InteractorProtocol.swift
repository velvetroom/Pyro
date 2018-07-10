import Foundation

public protocol InteractorProtocol:AnyObject {
    associatedtype Transition
    var transition:Transition? { get set }
    var presenter:InteractorDelegateProtocol? { get set }
    
    init()
    func didLoad()
}

public extension InteractorProtocol {
    func didLoad() { }
}
