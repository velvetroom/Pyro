import Foundation

class Validate<RequestType:RequestProtocol>:ValidateProtocol, ValidateDelegate {
    weak var delegate:ValidateDelegate?
    var composite:ValidateComposite<RequestType>?
    private let dispatch:DispatchQueue
    
    required init() {
        self.dispatch = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func validate(pyro:Pyro, url:String) {
        self.composite = ValidateComposite()
        self.composite?.delegate = self
        self.dispatch.async { [weak self] in
            self?.composite?.validate(pyro:pyro, url:url)
        }
    }
    
    func validateSuccess() {
        DispatchQueue.main.async { [weak self] in self?.delegate?.validateSuccess() }
    }
    
    func validateFailed(error:Error) {
        DispatchQueue.main.async { [weak self] in self?.delegate?.validateFailed(error:error) }
    }
}

private struct Constants {
    static let identifier:String = "pyro.validate"
}
