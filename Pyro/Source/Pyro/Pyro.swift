import Foundation

class Pyro:PyroProtocol {
    var store:Store
    var storage:StorageProtocol
    var users:[User] { get { return self.store.users } }
    
    init() {
        self.store = Store()
        self.storage = Storage()
    }
    
    func load(onCompletion:@escaping(() -> Void)) {
        self.storage.load { [weak self] (store:Store) in
            self?.store = store
            onCompletion()
        }
    }
    
    func addUser(name:String, url:String) {
        var user:User = User()
        user.identifier = UUID().uuidString
        user.name = name
        user.url = url
        self.add(user:user)
        self.save()
    }
    
    func save() {
        self.storage.save(store:self.store)
    }
    
    private func add(user:User) {
        self.store.users.append(user)
        self.store.users.sort { (userA:User, userB:User) -> Bool in
            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        }
    }
}
