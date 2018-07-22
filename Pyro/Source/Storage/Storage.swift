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
            guard let users:[User] = self?.loadUsers() else { return }
            DispatchQueue.main.async {
                onCompletion(users)
            }
        }
    }
    
    func load(onCompletion:@escaping((Session) -> Void)) {
        self.dispatch.async { [weak self] in
            guard let session:Session = self?.loadSession() else { return }
            DispatchQueue.main.async {
                onCompletion(session)
            }
        }
    }
    
    func save(users:[User]) { self.save(model:users, name:Constants.storeFile) }
    func save(session:Session) { self.save(model:session, name:Constants.sessionFile) }
    
    private func loadUsers() -> [User] {
        var users:[User] = []
        do {
            try users = self.load(name:Constants.storeFile)
        } catch {
            do { try users = self.loadUserBase() } catch { }
        }
        return users
    }
    
    private func loadSession() -> Session {
        let session:Session
        do {
            try session = self.load(name:Constants.sessionFile)
        } catch {
            session = Session()
            self.save(session:session)
        }
        return session
    }
    
    private func load<Model:Decodable>(name:String) throws -> Model {
        return try self.decode(data:try self.file.load(name:name))
    }
    
    private func loadUserBase() throws -> [User] {
        let userBase:[UserBase] = try self.decode(data:try self.file.loadFromBundle(name:Constants.userBaseFile))
        let users:[User] = UserFactory.makeFrom(userBase:userBase)
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
