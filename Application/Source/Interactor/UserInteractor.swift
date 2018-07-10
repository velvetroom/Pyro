import Foundation
import CleanArchitecture
import Pyro

class UserInteractor:InteractorProtocol {
    weak var transition:Navigation?
    weak var presenter:InteractorDelegateProtocol?
    var users:[User]
    
    required init() {
        self.users = []
    }
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        let storage:Storage = Storage()
        storage.load { [weak self] (users:[User]) in
            self?.users = users
            onCompletion(users)
        }
    }
}
