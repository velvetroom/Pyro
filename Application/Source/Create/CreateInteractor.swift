import Foundation
import CleanArchitecture
import Pyro

class CreateInteractor:Interactor, PyroDelegate {
    weak var delegate:InteractorDelegate?
    weak var pyro:Pyro!
    var error:Error?
    var profile:Profile?
    private var url:String
    
    required init() {
        self.url = String()
    }
    
    func validate(url:String) {
        self.url = url
        self.error = nil
        self.profile = nil
        self.pyro.delegate = self
        self.pyro.validate(url:url)
    }
    
    func pyroValidated() {
        self.pyro.loadProfile(url:self.url)
    }
    
    func pyroFailed(error:Error) {
        self.error = error
        self.delegate?.shouldUpdate()
    }
    
    func pyroLoaded(profile:Profile) {
        self.profile = profile
        self.delegate?.shouldUpdate()
    }
}
