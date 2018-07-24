import Foundation
@testable import Pyro

class MockStorageFileProtocol:StorageFileProtocol {
    var onSave:(() -> Void)?
    var onLoad:(() -> Void)?
    var onLoadFromBundle:(() -> Void)?
    var error:Error?
    var data:Data
    
    init() {
        self.data = Data()
    }
    
    func load(name:String) throws -> Data {
        self.onLoad?()
        if let error:Error = self.error {
            self.error = nil
            throw error
        } else {
            return self.data
        }
    }
    
    func loadFromBundle(name:String) throws -> Data {
        self.onLoadFromBundle?()
        if let error:Error = self.error {
            self.error = nil
            throw error
        } else {
            return self.data
        }
    }
    
    func save(data:Data, name:String) throws {
        self.onSave?()
        if let error:Error = self.error {
            self.error = nil
            throw error
        }
    }
}
