import Foundation
@testable import Pyro

class MockStorageProtocol:StorageProtocol {
    var onLoadUsers:(() -> Void)?
    var onLoadSession:(() -> Void)?
    var onSaveUsers:(() -> Void)?
    var onSaveSession:(() -> Void)?
    
    func load(onCompletion:@escaping(([UserProtocol]) -> Void)) {
        self.onLoadUsers?()
        onCompletion([])
    }
    
    func load(onCompletion:@escaping((SessionProtocol) -> Void)) {
        self.onLoadSession?()
        onCompletion(Session_v1())
    }
    
    func save(users:[UserProtocol]) {
        self.onSaveUsers?()
    }
    
    func save(session:SessionProtocol) {
        self.onSaveSession?()
    }
}
