import Foundation

class UserFactory {
    class func make() -> User {
        let user:User = User()
        user.identifier = UUID().uuidString
        return user
    }
    
    class func makeFrom(userBase:[UserBase]) -> [User] {
        var users:[User] = []
        for base:UserBase in userBase {
            let user:User = make()
            user.name = base.name
            user.url = base.url
            users.append(user)
        }
        return users
    }
    
    private init() { }
}
