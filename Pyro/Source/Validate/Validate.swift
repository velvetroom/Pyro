import Foundation

class Validate<RequestType:RequestProtocol>:ValidateProtocol, ValidateDelegate {
    weak var delegate:ValidateDelegate?
    weak var pyro:Pyro!
    var commands:[ValidateProtocol.Type]
    var url:String
    let dispatch:DispatchQueue
    
    required init() {
        self.commands = []
        self.url = String()
        self.dispatch = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                      attributes:DispatchQueue.Attributes.concurrent,
                                      autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                      target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func validate(pyro:Pyro, url:String) {
        self.pyro = pyro
        self.url = url
        self.dispatch.async { [weak self] in self?.startValidation() }
    }
    
    func validateSuccess() {
        if let commandType:ValidateProtocol.Type = self.commands.popLast() {
            let command:ValidateProtocol = commandType.init()
            command.delegate = self
            command.validate(pyro:self.pyro, url:self.url)
        } else {
            DispatchQueue.main.async { [weak self] in self?.delegate?.validateSuccess() }
        }
    }
    
    func validateFailed(error:Error) {
        DispatchQueue.main.async { [weak self] in self?.delegate?.validateFailed(error:error) }
    }
    
    private func startValidation() {
        self.commands = [
            ValidateEmpty.self,
            ValidateFirst.self,
            ValidateCharacters.self,
            ValidateUnique.self,
            ValidateExists<RequestType>.self]
        self.commands.reverse()
        self.validateSuccess()
    }
}

private struct Constants {
    static let identifier:String = "pyro.validate"
}
