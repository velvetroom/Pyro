import Foundation
@testable import Pyro

class MockStorageProtocol:StorageProtocol {
    var onLoad:(() -> Void)?
    var onSave:(() -> Void)?
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        self.onLoad?()
        onCompletion([])
    }
    
    func save(users:[User]) {
        self.onSave?()
    }
}
