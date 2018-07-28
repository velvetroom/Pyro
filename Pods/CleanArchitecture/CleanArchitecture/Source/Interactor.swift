import Foundation

public protocol Interactor:AnyObject {
    var delegate:InteractorDelegate? { get set }
    
    init()
    func didLoad()
}

public extension Interactor {
    func didLoad() { }
}
