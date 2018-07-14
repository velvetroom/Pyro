import Foundation
import Pyro

class MockPyroDelegate:PyroDelegate {
    var onUpdated:(() -> Void)?
    var onError:(() -> Void)?
    
    func pyroUpdated() {
        self.onUpdated?()
    }
    
    func pyroFailed(error:Error) {
        self.onError?()
    }
}
