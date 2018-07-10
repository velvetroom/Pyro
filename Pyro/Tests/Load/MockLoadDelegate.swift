import Foundation
@testable import Pyro

class MockLoadDelegate:LoadDelegate {
    var onCompleted:(() -> Void)?
    var onError:(() -> Void)?
    
    func loadCompleted(items:[ScraperItem]) {
        self.onCompleted?()
    }
    
    func loadFailed(error:Error) {
        self.onError?()
    }
}
