import Foundation

class UserFactory {
    class func make() -> User {
        var user:User = User()
        user.identifier = UUID().uuidString
        return user
    }
    
    private init() { }
}
