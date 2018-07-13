import Foundation
@testable import Pyro

class MockStorageFileProtocol:StorageFileProtocol {
    var onSave:(() -> Void)?
    var onLoad:(() -> Void)?
    var error:Error?
    
    func load() throws -> Data {
        self.onLoad?()
        if let error:Error = self.error {
            throw error
        } else {
            return Data()
        }
    }
    
    func save(data:Data) throws {
        self.onSave?()
        if let error:Error = self.error {
            throw error
        }
    }
}
