import Foundation

public protocol PyroProtocol:AnyObject {
    var users:[User] { get }
    
    func load(onCompletion:@escaping(() -> Void))
    func save()
    func addUser(name:String, url:String)
}
