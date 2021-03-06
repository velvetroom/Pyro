import Foundation

class ValidateEmpty:ValidateProtocol {
    weak var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        if url.isEmpty {
            self.delegate?.validateFailed(error:ValidateError.empty)
        } else {
            self.delegate?.validateSuccess()
        }
    }
}
