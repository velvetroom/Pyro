import Foundation
import CleanArchitecture
import Pyro

class StatsInteractor:InteractorProtocol, PyroDelegate {
    weak var router:Router?
    weak var presenter:InteractorDelegateProtocol?
    weak var pyro:Pyro!
    weak var user:User!
    var error:Error?
    
    required init() { }
    
    func synchStats() {
        self.pyro.delegate = self
        self.pyro.makeReport(user:self.user)
    }
    
    func delete() {
        self.pyro.delete(user:self.user)
        self.router?.popViewController(animated:true)
    }
    
    func pyroUpdated() {
        self.error = nil
        self.presenter?.shouldUpdate()
    }
    
    func pyroFailed(error:Error) {
        self.error = error
        self.presenter?.shouldUpdate()
    }
}
