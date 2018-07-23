import Foundation

class UserFactory {
    class func make() -> User_v1 {
        let user:User_v1 = User_v1()
        user.identifier = UUID().uuidString
        return user
    }
    
    class func makeFrom(userBase:[UserBase]) -> [User_v1] {
        var users:[User_v1] = []
        for base:UserBase in userBase {
            let user:User_v1 = make()
            user.name = base.name
            user.url = base.url
            users.append(user)
        }
        return users
    }
    
    private init() { }
}
