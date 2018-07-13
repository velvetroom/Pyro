import Foundation
import CleanArchitecture
import Pyro

class UserInteractor:InteractorProtocol {
    weak var transition:Navigation?
    weak var presenter:InteractorDelegateProtocol?
    var pyro:PyroProtocol
    
    required init() {
        self.pyro = Factory.makePyro()
    }
    
    func load(onCompletion:@escaping(() -> Void)) {
        self.pyro.load(onCompletion:onCompletion)
    }
    
    func selectUser(index:Int) {
        self.transition?.routeToUsers(pyro:self.pyro, user:self.pyro.users[index])
    }
    
    func add(name:String, url:String) {
        self.pyro.addUser(name:name, url:url)
    }
}
