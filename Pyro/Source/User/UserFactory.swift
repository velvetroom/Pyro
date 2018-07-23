import Foundation

class UserFactory {
    class func make(userBase:[UserBase]) -> [UserProtocol] {
        var users:[UserProtocol] = []
        for base:UserBase in userBase {
            let user:UserProtocol = Configuration.User()
            user.name = base.name
            user.url = base.url
            users.append(user)
        }
        return users
    }
    
    private init() { }
}
