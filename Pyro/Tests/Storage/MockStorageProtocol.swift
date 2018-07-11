import Foundation
import Pyro

class MockStorageProtocol:StorageProtocol {
    var onLoad:(() -> Void)?
    var onSave:(() -> Void)?
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        self.onLoad?()
    }
    
    func save(users:[User], onCompletion:@escaping(() -> Void)) {
        self.onSave?()
    }
}
