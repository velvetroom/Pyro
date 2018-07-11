import Foundation

protocol StorageFileProtocol {
    func load() throws -> Data
    func save(data:Data) throws
}
