import Foundation

public protocol InteractorProtocol:AnyObject {
    associatedtype Router
    var router:Router? { get set }
    var presenter:InteractorDelegateProtocol? { get set }
    
    init()
    func didLoad()
}

public extension InteractorProtocol {
    func didLoad() { }
}
