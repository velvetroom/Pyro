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
    
    func load(onCompletion:@escaping(([UserProtocol]) -> Void)) {
        self.dispatch.async { [weak self] in
            guard let users:[UserProtocol] = self?.loadUsers() else { return }
            DispatchQueue.main.async {
                onCompletion(users)
            }
        }
    }
    
    func load(onCompletion:@escaping((SessionProtocol) -> Void)) {
        self.dispatch.async { [weak self] in
            guard let session:SessionProtocol = self?.loadSession() else { return }
            DispatchQueue.main.async {
                onCompletion(session)
            }
        }
    }
    
    func save(users:[UserProtocol]) {
        self.save(model:users as! [Configuration.User], name:Constants.storeFile)
    }
    func save(session:SessionProtocol) {
        self.save(model:session as! Configuration.Session, name:Constants.sessionFile)
    }
    
    func loadUsers() -> [UserProtocol] {
        var users:[UserProtocol] = []
        do {
            try users = self.loadStoredUsers()
        } catch {
            do { try users = self.loadUserBase() } catch { }
        }
        return users
    }
    
    func loadStoredUsers() throws -> [UserProtocol] {
        var users:[UserProtocol] = []
        do {
            let current:[Configuration.User] = try self.load(name:Constants.storeFile)
            users = current
        } catch {
            let previous:[User_v1] = try self.load(name:Constants.storeFile)
            for oldUser:User_v1 in previous {
                users.append(UserFactory.migrate(user:oldUser))
            }
        }
        return users
    }
    
    private func loadSession() -> SessionProtocol {
        let session:SessionProtocol
        do {
            let saved:Configuration.Session = try self.load(name:Constants.sessionFile)
            session = saved
        } catch {
            session = SessionFactory.make()
            self.save(session:session)
        }
        return session
    }
    
    private func load<Model:Decodable>(name:String) throws -> Model {
        return try self.decode(data:try self.file.load(name:name))
    }
    
    private func loadUserBase() throws -> [UserProtocol] {
        let userBase:[UserBase] = try self.decode(data:try self.file.loadFromBundle(name:Constants.userBaseFile))
        let users:[UserProtocol] = UserFactory.make(userBase:userBase)
        self.save(users:users)
        return users
    }
    
    private func save<Model:Encodable>(model:Model, name:String) {
        self.dispatch.async { [weak self] in
            do { try self?.file.save(data:try JSONEncoder().encode(model), name:name) } catch { }
        }
    }
    
    private func decode<Model:Decodable>(data:Data) throws -> Model {
        return try JSONDecoder().decode(Model.self, from:data)
    }
}

private struct Constants {
    static let identifier:String = "pyro.storage"
    static let userBaseFile:String = "UserBase.json"
    static let storeFile:String = "Store.json"
    static let sessionFile:String = "Session.json"
}
