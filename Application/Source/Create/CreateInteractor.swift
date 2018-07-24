import Foundation
import CleanArchitecture
import Pyro

class CreateInteractor:InteractorProtocol, PyroDelegate {
    weak var router:Router?
    weak var presenter:InteractorDelegate?
    weak var pyro:Pyro!
    var error:Error?
    
    required init() { }
    
    func validate(url:String) {
        self.pyro.delegate = self
        self.pyro.validate(url:url)
    }
    
    func pyroSuccess() {
        self.error = nil
        self.presenter?.shouldUpdate()
    }
    
    func pyroFailed(error:Error) {
        self.error = error
        self.presenter?.shouldUpdate()
    }
}
