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
    
    func save() {
        guard let profile:Profile = self.profile else { return }
        self.pyro.addUser(profile:profile)
    }
    
    func validate(url:String) {
        self.url = url
        self.error = nil
        self.profile = nil
        self.pyro.delegate = self
        self.pyro.validate(url:url)
    }
    
    func pyroValidated() {
        self.error = nil
        self.profile = nil
        self.pyro.loadProfile(url:self.url)
        self.delegate?.shouldUpdate()
    }
    
    func pyroFailed(error:Error) {
        self.profile = nil
        self.error = error
        self.delegate?.shouldUpdate()
    }
    
    func pyroLoaded(profile:Profile) {
        self.error = nil
        self.profile = profile
        self.delegate?.shouldUpdate()
    }
}
