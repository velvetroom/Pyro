import Foundation
import CleanArchitecture
import Pyro

class CreateInteractor:Interactor, PyroDelegate {
    weak var delegate:InteractorDelegate?
    weak var pyro:Pyro!
    var error:Error?
    
    required init() { }
    
    func validate(url:String) {
        self.pyro.delegate = self
        self.pyro.validate(url:url)
    }
    
    func pyroSuccess() {
        self.error = nil
        self.delegate?.shouldUpdate()
    }
    
    func pyroFailed(error:Error) {
        self.error = error
        self.delegate?.shouldUpdate()
    }
}
