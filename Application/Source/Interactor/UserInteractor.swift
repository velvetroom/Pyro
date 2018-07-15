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
        self.select(user:self.pyro.users[index])
    }
    
    func add(name:String, url:String) {
        self.pyro.delegate = self
        let user:User = self.pyro.addUser(name:name, url:url)
        self.select(user:user)
    }
    
    func pyroUpdated() {
        self.presenter?.shouldUpdate()
    }
    
    private func select(user:User) {
        self.router?.routeToUsers(pyro:self.pyro, user:user)
    }
}
