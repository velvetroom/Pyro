import Foundation

class UserFactory {
    class func make() -> User {
        let user:User = User()
        user.identifier = UUID().uuidString
        return user
    }
    
    private init() { }
}
