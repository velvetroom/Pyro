import Foundation

public protocol InteractorProtocol:AnyObject {
    var presenter:InteractorDelegateProtocol? { get set }
    
    init()
    func didLoad()
}
