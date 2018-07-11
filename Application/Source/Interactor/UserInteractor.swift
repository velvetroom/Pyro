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
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        self.storage.load { [weak self] (users:[User]) in
            self?.users = users
            onCompletion(users)
        }
    }
}
