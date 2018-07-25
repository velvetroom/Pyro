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
    
    func create(name:String, url:String) -> UserProtocol {
        self.pyro.delegate = self
        return self.pyro.addUser(name:name, url:url)
    }
    
    func pyroSuccess() {
        self.delegate?.shouldUpdate()
    }
    
    func didLoad() {
        self.pyro.loadSession()
    }
}
