import Foundation

public class Pyro:ReportDelegate, ValidateDelegate {
    public var users:[UserProtocol]
    public weak var delegate:PyroDelegate?
    var storage:StorageProtocol
    var report:ReportProtocol
    var session:SessionProtocol
    var validate:ValidateProtocol?
    
    public init() {
        self.users = []
        self.session = SessionFactory.make()
        self.storage = Storage()
        self.report = Report()
        self.report.delegate = self
    }
    
    public func loadUsers() {
        self.storage.load { [weak self] (users:[UserProtocol]) in
            self?.users = users
            self?.delegate?.pyroSuccess()
        }
    }
    
    @discardableResult public func addUser(name:String, url:String) -> UserProtocol {
        let user:UserProtocol = UserFactory.make()
        user.name = name
        user.url = url
        self.add(user:user)
        self.saveUsers()
        self.delegate?.pyroSuccess()
        return user
    }
    
    public func delete(user:UserProtocol) {
        self.users.removeAll { (listedUser:UserProtocol) -> Bool in return user === listedUser }
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
    
    public func validate(url:String) {
        self.validate?.delegate = nil
        self.validate = Validate<Request>()
        self.validate?.delegate = self
        self.validate?.validate(pyro:self, url:url)
    }
    
    public func loadSession() { self.storage.load { [weak self] (session:SessionProtocol) in self?.session = session } }
    public func makeReport(user:UserProtocol) { self.report.make(user:user) }
    func saveUsers() { self.storage.save(users:self.users) }
    func saveSession() { self.storage.save(session:self.session) }
    func reportFailed(error:Error) { self.delegate?.pyroFailed(error:error) }
    func report(progress:Float) { self.delegate?.pyroReport(progress:progress) }
    func validateSuccess() { self.delegate?.pyroSuccess() }
    func validateFailed(error:Error) { self.delegate?.pyroFailed(error:error) }
    
    func reportCompleted() {
        self.session.reports += 1
        self.saveSession()
        self.saveUsers()
        self.delegate?.pyroSuccess()
    }
    
    private func add(user:UserProtocol) {
        self.users.append(user)
        self.users.sort { (userA:UserProtocol, userB:UserProtocol) -> Bool in
            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        }
    }
}

private struct Constants {
    static let reportsToRate:Int = 3
}
