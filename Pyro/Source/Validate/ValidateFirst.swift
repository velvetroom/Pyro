import Foundation

class ValidateFirst:ValidateProtocol {
    weak var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        guard
            let first:UInt8 = url.utf8.first,
            first < "0".utf8.first! || first > "9".utf8.first!,
            first != "-".utf8.first!
        else {
            self.delegate?.validateFailed(error:ValidateError.first)
            return
        }
        self.delegate?.validateSuccess()
    }
}
