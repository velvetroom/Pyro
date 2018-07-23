import Foundation
@testable import Pyro

class MockLoadProtocol:LoadProtocol {
    var onStart:(() -> Void)?
    var items:[ScraperItem]?
    var error:Error?
    weak var delegate:LoadDelegate?
    
    func start(user:User_v1) {
        self.onStart?()
        if let error:Error = self.error {
            self.delegate?.loadFailed(error:error)
        } else if let items:[ScraperItem] = self.items {
            self.delegate?.loadCompleted(items:items)
        }
    }
}
