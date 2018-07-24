import Foundation

class ValidateExists<RequestType:RequestProtocol>:ValidateProtocol {
    var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        RequestType().validate(url:url, onCompletion: { [weak self] in
            self?.delegate?.validateSuccess()
        }, onError: { [weak self] (error:Error) in
            self?.delegate?.validateFailed(error:error)
        })
    }
}
