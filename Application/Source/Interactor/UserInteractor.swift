import Foundation
import CleanArchitecture
import Pyro

class UserInteractor:InteractorProtocol {
    weak var transition:Navigation?
    weak var presenter:InteractorDelegateProtocol?
    var users:[User]
    private let storage:StorageProtocol
    
    required init() {
        self.users = []
        self.storage = Factory.makeStorage()
    }
    
    func load(onCompletion:@escaping(() -> Void)) {
        self.storage.load { [weak self] (users:[User]) in
            self?.users = users
            onCompletion()
        }
    }
    
    func add(name:String, url:String) {
        var user:User = User()
        user.name = name
        user.url = url
        self.users.append(user)
        self.users.sort { (userA:User, userB:User) -> Bool in
            return userA.name.caseInsensitiveCompare(userB.name) == ComparisonResult.orderedAscending
        }
        self.storage.save(users:self.users)
    }
}
