import Foundation
import CleanArchitecture
import Pyro

class UsersInteractor:Interactor, PyroDelegate {
    weak var delegate:InteractorDelegate?
    var pyro:Pyro
    
    required init() {
        self.pyro = Pyro()
    }
    
    func updateUsers() {
        self.pyro.delegate = self
        self.pyro.loadUsers()
    }
    
    func pyroUsersLoaded() {
        self.delegate?.shouldUpdate()
    }
    
    func didLoad() {
        self.pyro.loadSession()
    }
}
