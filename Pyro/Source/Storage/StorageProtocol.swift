import Foundation

protocol StorageProtocol {
    func load(onCompletion:@escaping(([UserProtocol]) -> Void))
    func load(onCompletion:@escaping((SessionProtocol) -> Void))
    func save(users:[UserProtocol])
    func save(session:SessionProtocol)
}
