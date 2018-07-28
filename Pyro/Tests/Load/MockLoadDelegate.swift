import Foundation
@testable import Pyro

class MockLoadDelegate:LoadDelegate {
    var onCompleted:(() -> Void)?
    var onError:(() -> Void)?
    var onProgress:(() -> Void)?
    
    func load(progress:Float) {
        self.onProgress?()
    }
    
    func loadCompleted(items:[ScraperItem]) {
        self.onCompleted?()
    }
    
    func loadFailed(error:Error) {
        self.onError?()
    }
}
