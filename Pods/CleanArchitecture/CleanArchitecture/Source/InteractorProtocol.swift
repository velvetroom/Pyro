import Foundation

public protocol InteractorProtocol:AnyObject {
    associatedtype Router
    var router:Router? { get set }
    var presenter:InteractorDelegate? { get set }
    
    init()
    func didLoad()
}

public extension InteractorProtocol {
    func didLoad() { }
}
