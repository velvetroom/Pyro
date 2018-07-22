import Foundation

protocol StorageFileProtocol {
    func load(name:String) throws -> Data
    func loadFromBundle(name:String) throws -> Data
    func save(data:Data, name:String) throws
}
