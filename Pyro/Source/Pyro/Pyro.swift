import Foundation

class Pyro:PyroProtocol {
    var users:[User]
    var storage:StorageProtocol
    
    init() {
        self.users = []
        self.storage = Storage()
    }
    
    func load(onCompletion:@escaping(() -> Void)) {
        self.storage.load { [weak self] (users:[User]) in
            self?.users = users
            onCompletion()
        }
    }
    
    func addUser(name:String, url:String) {
        var user:User = UserFactory.make()
        user.name = name
        user.url = url
        self.add(user:user)
        self.save()
    }
    
    func save() {
        self.storage.save(users:self.users)
    }
    
    private func add(user:User) {
        self.users.append(user)
        self.users.sort { (userA:User, userB:User) -> Bool in
            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        }
    }
}