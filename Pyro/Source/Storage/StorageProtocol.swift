import Foundation

protocol StorageProtocol {
    func load(onCompletion:@escaping((Store) -> Void))
    func save(store:Store)
}
