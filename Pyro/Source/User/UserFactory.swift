import Foundation

class UserFactory {
    class func make() -> UserProtocol { return Configuration.User() }
    
    class func make(userBase:[UserBase]) -> [UserProtocol] {
        var users:[UserProtocol] = []
        for base:UserBase in userBase {
            let user:UserProtocol = make()
            user.name = base.name
            user.url = base.url
            users.append(user)
        }
        return users
    }
    
    private init() { }
}
