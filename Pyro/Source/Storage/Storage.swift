import Foundation

class Storage:StorageProtocol {
    var userDefaults:UserDefaults
    private let dispatch:DispatchQueue
    
    init() {
        self.userDefaults = UserDefaults(suiteName:StorageConstants.suite)!
        self.dispatch = DispatchQueue(label:StorageConstants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        self.dispatch.async { [weak self] in
            guard
                let users:[User] = self?.loadUsers()
            else { return }
            DispatchQueue.main.async { onCompletion(users) }
        }
    }
    
    func save(users:[User], onCompletion:@escaping(() -> Void)) {
        self.dispatch.async { [weak self] in
            guard
                let array:[[String:Any]] = self?.serialise(users:users)
            else { return }
            self?.saveUsers(array:array)
            DispatchQueue.main.async { onCompletion() }
        }
    }
    
    private func loadUsers() -> [User] {
        let users:[User]
        do {
            try users = self.loadUsersFromStorage()
        } catch {
            users = self.loadUsersFromDefault()
        }
        return users
    }
    
    private func loadUsersFromStorage() throws -> [User] {
        guard
            let array:[[String:Any]] = self.userDefaults.value(forKey:StorageConstants.users) as? [[String:Any]]
        else { throw StorageError.firstTime }
        return self.deserialise(array:array)
    }
    
    private func loadUsersFromDefault() -> [User] {
        let url:URL = Bundle(for:type(of:self)).url(forResource:StorageConstants.defaultFile, withExtension:nil)!
        let array:[[String:Any]]
        do {
            let data:Data = try Data(contentsOf:url, options:Data.ReadingOptions.mappedIfSafe)
            try array = JSONSerialization.jsonObject(with:data,
                                                     options:JSONSerialization.ReadingOptions()) as! [[String:Any]]
        } catch { return [] }
        self.saveUsers(array:array)
        return self.deserialise(array:array)
    }
    
    private func deserialise(array:[[String:Any]]) -> [User] {
        var users:[User] = []
        for item:[String:Any] in array {
            var user:User = User()
            user.name = item[StorageConstants.name] as! String
            user.url = item[StorageConstants.url] as! String
            users.append(user)
        }
        return users
    }
    
    private func serialise(users:[User]) -> [[String:Any]] {
        var array:[[String:Any]] = []
        for user:User in users {
            array.append([StorageConstants.name : user.name, StorageConstants.url : user.url])
        }
        return array
    }
    
    private func saveUsers(array:[[String:Any]]) {
        self.userDefaults.set(array, forKey:StorageConstants.users)
    }
}
