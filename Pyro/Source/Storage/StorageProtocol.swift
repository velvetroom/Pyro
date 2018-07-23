import Foundation

protocol StorageProtocol {
    func load(onCompletion:@escaping(([User_v1]) -> Void))
    func load(onCompletion:@escaping((Session) -> Void))
    func save(users:[User_v1])
    func save(session:Session)
}
