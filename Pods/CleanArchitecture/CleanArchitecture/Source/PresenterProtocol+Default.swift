import Foundation

public extension PresenterProtocol {
    func didLoad() { }
    func willAppear() { }
    func didAppear() { }
    func orientationChanged() { }
    
    func startTransition<Transition>(completion:((Transition) -> Void)) {
        guard
            let transition:Transition = self.transition as? Transition
        else { return }
        completion(transition)
    }
}
