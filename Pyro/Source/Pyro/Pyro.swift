import Foundation

public class Pyro:ReportDelegate {
    public var users:[User_v1]
    public weak var delegate:PyroDelegate?
    var storage:StorageProtocol
    var report:ReportProtocol
    var session:Session
    
    public init() {
        self.users = []
        self.session = Session()
        self.storage = Storage()
        self.report = Report()
        self.report.delegate = self
    }
    
    public func loadUsers() {
        self.storage.load { [weak self] (users:[User_v1]) in
            self?.users = users
            self?.delegate?.pyroUpdated()
        }
    }
    
    @discardableResult public func addUser(name:String, url:String) -> User_v1 {
        let user:User_v1 = UserFactory.make()
        user.name = name
        user.url = url
        self.add(user:user)
        self.saveUsers()
        self.delegate?.pyroUpdated()
        return user
    }
    
    public func delete(user:User_v1) {
        self.users.removeAll { (listedUser:User_v1) -> Bool in return listedUser === user }
        self.saveUsers()
    }
    
    public func shouldRate() -> Bool {
        guard
            self.session.rates.isEmpty,
            self.session.reports == Constants.reportsToRate
        else { return false }
        self.session.rates.append(Date())
        self.saveSession()
        return true
    }
    
    public func loadSession() { self.storage.load { [weak self] (session:Session) in self?.session = session } }
    public func makeReport(user:User_v1) { self.report.make(user:user) }
    func saveUsers() { self.storage.save(users:self.users) }
    func saveSession() { self.storage.save(session:self.session) }
    func reportFailed(error:Error) { self.delegate?.pyroFailed(error:error) }
    func report(progress:Float) { self.delegate?.pyroReport(progress:progress) }
    
    func reportCompleted() {
        self.session.reports += 1
        self.saveSession()
        self.saveUsers()
        self.delegate?.pyroUpdated()
    }
    
    private func add(user:User_v1) {
        self.users.append(user)
        self.users.sort { (userA:User_v1, userB:User_v1) -> Bool in
            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        }
    }
}

private struct Constants {
    static let reportsToRate:Int = 3
}
