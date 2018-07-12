import Foundation

class Storage:StorageProtocol {
    var store:Store
    var file:StorageFileProtocol
    private let dispatch:DispatchQueue
    
    init() {
        self.store = Store()
        self.file = StorageFile()
        self.dispatch = DispatchQueue(label:StorageConstants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        self.dispatch.async { [weak self] in
            do { try self?.loadFromFile() } catch { do { try self?.loadUserBase() } catch { } }
            DispatchQueue.main.async { [weak self] in
                guard let store:Store = self?.store else { return }
                onCompletion(store.users)
            }
        }
    }
    
    func save(users:[User]) {
        self.dispatch.async { [weak self] in
            self?.store.users = users
            self?.save()
        }
    }
    
    private func loadFromFile() throws {
        let data:Data = try self.file.load()
        try self.store = JSONDecoder().decode(Store.self, from:data)
    }
    
    private func loadUserBase() throws {
        let url:URL = Bundle(for:type(of:self)).url(forResource:StorageConstants.userBaseFile, withExtension:nil)!
        let data:Data = try Data(contentsOf:url, options:Data.ReadingOptions.uncached)
        let userBase:[UserBase] = try JSONDecoder().decode([UserBase].self, from:data)
        self.createUsersFrom(userBase:userBase)
        self.save()
    }
    
    private func save() {
        let data:Data
        do {
            try data = JSONEncoder().encode(self.store)
            try self.file.save(data:data)
        } catch { }
    }
    
    private func createUsersFrom(userBase:[UserBase]) {
        var store:Store = Store()
        for base:UserBase in userBase {
            var user:User = User()
            user.name = base.name
            user.url = base.url
            user.identifier = UUID().uuidString
            store.users.append(user)
        }
        self.store = store
    }
}
