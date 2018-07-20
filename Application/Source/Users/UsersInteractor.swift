import Foundation
import CleanArchitecture
import Pyro

class UsersInteractor:InteractorProtocol, PyroDelegate {
    weak var router:Router?
    weak var presenter:InteractorDelegateProtocol?
    var pyro:Pyro
    
    required init() {
        self.pyro = Pyro()
    }
    
    func load() {
        self.pyro.delegate = self
        self.pyro.load()
    }
    
    func select(user:User) {
        self.router?.routeToStats(pyro:self.pyro, user:user)
    }
    
    func add(name:String, url:String) {
        self.pyro.delegate = self
        let user:User = self.pyro.addUser(name:name, url:url)
        self.select(user:user)
    }
    
    func pyroUpdated() {
        self.presenter?.shouldUpdate()
    }
}
