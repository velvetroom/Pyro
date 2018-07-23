import Foundation
@testable import Pyro

class MockStorageProtocol:StorageProtocol {
    var onLoadUsers:(() -> Void)?
    var onLoadSession:(() -> Void)?
    var onSaveUsers:(() -> Void)?
    var onSaveSession:(() -> Void)?
    
    func load(onCompletion:@escaping(([User_v1]) -> Void)) {
        self.onLoadUsers?()
        onCompletion([])
    }
    
    func load(onCompletion:@escaping((Session) -> Void)) {
        self.onLoadSession?()
        onCompletion(Session())
    }
    
    func save(users:[User_v1]) {
        self.onSaveUsers?()
    }
    
    func save(session:Session) {
        self.onSaveSession?()
    }
}
