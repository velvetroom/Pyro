import Foundation
@testable import Pyro

class MockValidateProtocol:ValidateProtocol {
    var onValidate:(() -> Void)?
    weak var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        self.onValidate?()
    }
}
