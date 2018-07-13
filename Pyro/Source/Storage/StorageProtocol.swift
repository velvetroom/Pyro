import Foundation

public protocol StorageProtocol {
    func load(onCompletion:@escaping(([User]) -> Void))
    func save(users:[User])
}
