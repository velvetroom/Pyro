import Foundation

class StorageFile:StorageFileProtocol {
    private let url:URL
    
    init() {
        let app:URL = FileManager.default.urls(for:FileManager.SearchPathDirectory.documentDirectory,
                                               in:FileManager.SearchPathDomainMask.userDomainMask).last!
        self.url = app.appendingPathComponent(Constants.storeFile)
    }
    
    func load() throws -> Data {
        guard FileManager.default.fileExists(atPath:self.url.path) else { throw StorageError.fileNotFound }
        return try Data(contentsOf:self.url, options:Data.ReadingOptions.uncached)
    }
    
    func save(data:Data) throws {
        try self.delete()
        try data.write(to:self.self.url, options:Data.WritingOptions.atomic)
    }
    
    private func delete() throws {
        if FileManager.default.fileExists(atPath:self.url.path) {
            try FileManager.default.removeItem(at:self.url)
        }
    }
}

private struct Constants {
    static let storeFile:String = "Store.json"
}
