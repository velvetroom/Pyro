import Foundation

public class Pyro:ReportDelegate {
    public var users:[User]
    public weak var delegate:PyroDelegate?
    var storage:StorageProtocol
    var report:ReportProtocol
    
    public init() {
        self.users = []
        self.storage = Storage()
        self.report = Report()
        self.report.delegate = self
    }
    
    public func load() {
        self.storage.load { [weak self] (users:[User]) in
            self?.users = users
            self?.delegate?.pyroUpdated()
        }
    }
    
    @discardableResult public func addUser(name:String, url:String) -> User {
        let user:User = UserFactory.make()
        user.name = name
        user.url = url
        self.add(user:user)
        self.save()
        self.delegate?.pyroUpdated()
        return user
    }
    
    public func makeReport(user:User) {
        self.report.make(user:user)
    }
    
    public func delete(user:User) {
        self.users.removeAll { (listedUser:User) -> Bool in return listedUser === user }
        self.save()
    }
    
    func save() {
        self.storage.save(users:self.users)
    }
    
    func reportCompleted() {
        self.save()
        self.delegate?.pyroUpdated()
    }
    
    func reportFailed(error:Error) {
        self.delegate?.pyroFailed(error:error)
    }
    
    private func add(user:User) {
        self.users.append(user)
        self.users.sort { (userA:User, userB:User) -> Bool in
            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        }
    }
}
