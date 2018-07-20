import Foundation

class Storage:StorageProtocol {
    var file:StorageFileProtocol
    private let dispatch:DispatchQueue
    
    init() {
        self.file = StorageFile()
        self.dispatch = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        self.dispatch.async { [weak self] in
            guard let users:[User] = self?.load() else { return }
            DispatchQueue.main.async {
                onCompletion(users)
            }
        }
    }
    
    func save(users:[User]) {
        self.dispatch.async { [weak self] in
            let data:Data
            do {
                try data = JSONEncoder().encode(users)
                try self?.file.save(data:data)
            } catch { }
        }
    }
    
    private func load() -> [User] {
        var users:[User] = []
        do {
            try users = self.loadFile()
        } catch {
            do { try users = self.loadUserBase() } catch { }
        }
        return users
    }
    
    private func loadFile() throws -> [User] {
        let data:Data = try self.file.load()
        return try JSONDecoder().decode([User].self, from:data)
    }
    
    private func loadUserBase() throws -> [User] {
        let url:URL = Bundle(for:type(of:self)).url(forResource:Constants.userBaseFile, withExtension:nil)!
        let data:Data = try Data(contentsOf:url, options:Data.ReadingOptions.uncached)
        let userBase:[UserBase] = try JSONDecoder().decode([UserBase].self, from:data)
        let users:[User] = self.createUsersFrom(userBase:userBase)
        self.save(users:users)
        return users
    }
    
    private func createUsersFrom(userBase:[UserBase]) -> [User] {
        var users:[User] = []
        for base:UserBase in userBase {
            let user:User = UserFactory.make()
            user.name = base.name
            user.url = base.url
            users.append(user)
        }
        return users
    }
}

private struct Constants {
    static let identifier:String = "pyro.storage"
    static let userBaseFile:String = "UserBase.json"
}
