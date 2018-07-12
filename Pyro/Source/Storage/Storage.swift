import Foundation

class Storage:StorageProtocol {
    var file:StorageFileProtocol
    private let dispatch:DispatchQueue
    
    init() {
        self.file = StorageFile()
        self.dispatch = DispatchQueue(label:StorageConstants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func load(onCompletion:@escaping((Store) -> Void)) {
        self.dispatch.async { [weak self] in
            guard let store:Store = self?.load() else { return }
            DispatchQueue.main.async {
                onCompletion(store)
            }
        }
    }
    
    func save(store:Store) {
        self.dispatch.async { [weak self] in
            let data:Data
            do {
                try data = JSONEncoder().encode(store)
                try self?.file.save(data:data)
            } catch { }
        }
    }
    
    private func load() -> Store {
        do {
            return try self.loadFile()
        } catch {
            do {
                return try self.loadUserBase()
            } catch {
                return Store()
            }
        }
    }
    
    private func loadFile() throws -> Store {
        let data:Data = try self.file.load()
        let store:Store = try JSONDecoder().decode(Store.self, from:data)
        return store
    }
    
    private func loadUserBase() throws -> Store {
        let url:URL = Bundle(for:type(of:self)).url(forResource:StorageConstants.userBaseFile, withExtension:nil)!
        let data:Data = try Data(contentsOf:url, options:Data.ReadingOptions.uncached)
        let userBase:[UserBase] = try JSONDecoder().decode([UserBase].self, from:data)
        let store:Store = self.createUsersFrom(userBase:userBase)
        self.save(store:store)
        return store
    }
    
    private func createUsersFrom(userBase:[UserBase]) -> Store {
        var store:Store = Store()
        for base:UserBase in userBase {
            var user:User = User()
            user.name = base.name
            user.url = base.url
            user.identifier = UUID().uuidString
            store.users.append(user)
        }
        return store
    }
}
