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
    
    func save() {
        self.storage.save(store:self.store)
    }
    
    func addUser(name:String, url:String) {
        //        var user:User = User()
        //        user.name = name
        //        user.url = url
        //        self.users.append(user)
        //        self.users.sort { (userA:User, userB:User) -> Bool in
        //            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        //        }
        //        self.storage.save(users:self.users)
    }
}
