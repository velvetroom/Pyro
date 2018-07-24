import Foundation

class UserFactory {
    class func make() -> UserProtocol {
        let user:Configuration.User =  Configuration.User()
        user.identifier = UUID().uuidString
        return user
    }
    
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
    
    class func migrate(user:User_v1) -> UserProtocol {
        let migrated:Configuration.User = Configuration.User()
        migrated.identifier = user.identifier
        migrated.name = user.name
        migrated.url = user.url
        migrated.metrics = user.metrics
        return migrated
    }
    
    private init() { }
}
