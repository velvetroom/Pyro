import Foundation
@testable import Pyro

class MockValidateDelegate:ValidateDelegate {
    var onValidateSuccess:(() -> Void)?
    var onValidateError:(() -> Void)?
    
    func validateSuccess() {
        self.onValidateSuccess?()
    }
    
    func validateFailed(error:Error) {
        self.onValidateError?()
    }
}
