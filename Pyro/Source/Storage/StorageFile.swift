import Foundation

class StorageFile:StorageFileProtocol {
    let appUrl:URL
    
    init() {
        self.appUrl = FileManager.default.urls(for:FileManager.SearchPathDirectory.documentDirectory,
                                               in:FileManager.SearchPathDomainMask.userDomainMask).last!
    }
    
    func load(name:String) throws -> Data {
        let url:URL = self.appUrl.appendingPathComponent(name)
        guard FileManager.default.fileExists(atPath:url.path) else { throw StorageError.fileNotFound }
        return try Data(contentsOf:url, options:Data.ReadingOptions.uncached)
    }
    
    func loadFromBundle(name:String) throws -> Data {
        let url:URL = Bundle(for:type(of:self)).url(forResource:name, withExtension:nil)!
        return try Data(contentsOf:url, options:Data.ReadingOptions.uncached)
    }
    
    func save(data:Data, name:String) throws {
        let url:URL = self.appUrl.appendingPathComponent(name)
        try self.delete(url:url)
        try data.write(to:url, options:Data.WritingOptions.atomic)
    }
    
    private func delete(url:URL) throws {
        if FileManager.default.fileExists(atPath:url.path) {
            try FileManager.default.removeItem(at:url)
        }
    }
}
