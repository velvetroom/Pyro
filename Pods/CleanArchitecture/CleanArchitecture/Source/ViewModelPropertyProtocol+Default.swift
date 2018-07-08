import Foundation

public extension ViewModelPropertyProtocol {
    func notifyObserver() {
        self.observing?(self)
    }
}
