import Foundation
@testable import Pyro

class MockStorageProtocol:StorageProtocol {
    var onLoad:(() -> Void)?
    var onSave:(() -> Void)?
    
    func load(onCompletion:@escaping((Store) -> Void)) {
        self.onLoad?()
        onCompletion(Store())
    }
    
    func save(store:Store) {
        self.onSave?()
    }
}
