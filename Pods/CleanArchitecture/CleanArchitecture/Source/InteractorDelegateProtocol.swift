import Foundation

public protocol InteractorDelegateProtocol:AnyObject {
    func shouldUpdate()
    func startTransition<Transition>(completion:((Transition) -> Void))
}
