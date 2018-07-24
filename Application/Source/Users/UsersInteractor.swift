import Foundation
import CleanArchitecture
import Pyro

class UsersInteractor:InteractorProtocol, PyroDelegate {
    weak var router:Router?
    weak var presenter:InteractorDelegate?
    var pyro:Pyro
    
    required init() {
        self.pyro = Pyro()
    }
    
    func load() {
        self.pyro.delegate = self
        self.pyro.loadUsers()
    }
    
    func createUser() {
        self.router?.routeToCreate(pyro:self.pyro)
    }
    
    func select(user:UserProtocol) {
        self.router?.routeToStats(pyro:self.pyro, user:user)
    }
    
    func add(name:String, url:String) {
        self.pyro.delegate = self
        let user:UserProtocol = self.pyro.addUser(name:name, url:url)
        self.select(user:user)
    }
    
    func pyroUpdated() {
        self.presenter?.shouldUpdate()
    }
    
    func didLoad() {
        self.pyro.loadSession()
    }
}
