import Foundation

class ValidateExists<RequestType:RequestProtocol>:ValidateProtocol {
    var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        RequestType().validate(url:url, onCompletion: { (data:Data) in
            self.delegate?.validateSuccess()
        }, onError: { (error:Error) in
            self.delegate?.validateFailed(error:error)
        })
    }
}
