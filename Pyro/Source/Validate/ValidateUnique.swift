import Foundation

class ValidateUnique:ValidateProtocol {
    weak var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        for user:UserProtocol in pyro.users {
            if user.url == url {
                self.delegate?.validateFailed(error:ValidateError.unique)
                return
            }
        }
        self.delegate?.validateSuccess()
    }
}
