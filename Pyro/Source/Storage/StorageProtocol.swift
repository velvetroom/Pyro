import Foundation

protocol StorageProtocol {
    func load(onCompletion:@escaping(([User]) -> Void))
    func load(onCompletion:@escaping((Session) -> Void))
    func save(users:[User])
    func save(session:Session)
}
