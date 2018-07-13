import Foundation

protocol StorageProtocol {
    func load(onCompletion:@escaping(([User]) -> Void))
    func save(users:[User])
}
