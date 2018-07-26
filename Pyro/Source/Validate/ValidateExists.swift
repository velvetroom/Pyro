import Foundation

class ValidateExists:ValidateProtocol {
    weak var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        Configuration.requestType.validate(url:url, onCompletion: { (data:Data) in
            self.delegate?.validateSuccess()
        }, onError: { (error:Error) in
            self.delegate?.validateFailed(error:error)
        })
    }
}
