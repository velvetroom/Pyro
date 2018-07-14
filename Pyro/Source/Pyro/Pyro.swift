import Foundation

public class Pyro {
    public var users:[User]
    var storage:StorageProtocol
    var report:ReportProtocol
    
    public init() {
        self.users = []
        self.storage = Storage()
        self.report = Report()
    }
    
    public func load(onCompletion:@escaping(() -> Void)) {
        self.storage.load { [weak self] (users:[User]) in
            self?.users = users
            onCompletion()
        }
    }
    
    public func addUser(name:String, url:String) {
        let user:User = UserFactory.make()
        user.name = name
        user.url = url
        self.add(user:user)
        self.save()
    }
    
    public func makeReport(user:User, delegate:ReportDelegate) {
        self.report.delegate = delegate
        self.report.make(user:user)
    }
    
    func save() {
        self.storage.save(users:self.users)
    }
    
    private func add(user:User) {
        self.users.append(user)
        self.users.sort { (userA:User, userB:User) -> Bool in
            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        }
    }
}
