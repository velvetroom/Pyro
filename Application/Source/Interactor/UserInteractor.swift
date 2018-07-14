import Foundation
import CleanArchitecture
import Pyro

class UserInteractor:InteractorProtocol, PyroDelegate {
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
    
    func selectUser(index:Int) {
        self.router?.routeToUsers(pyro:self.pyro, user:self.pyro.users[index])
    }
    
    func add(name:String, url:String) {
        self.pyro.delegate = self
        self.pyro.addUser(name:name, url:url)
    }
    
    func pyroUpdated() {
        self.presenter?.shouldUpdate()
    }
}
