import Foundation

class ValidateComposite:ValidateProtocol, ValidateDelegate {
    weak var delegate:ValidateDelegate?
    private weak var pyro:Pyro!
    private var commands:[ValidateProtocol.Type]
    private var url:String
    
    required init() {
        self.commands = [
            ValidateEmpty.self,
            ValidateFirst.self,
            ValidateCharacters.self,
            ValidateUnique.self,
            ValidateExists.self]
        self.commands.reverse()
        self.url = String()
    }
    
    func validate(pyro:Pyro, url:String) {
        self.pyro = pyro
        self.url = url
        self.validateSuccess()
    }
    
    func validateSuccess() {
        if let commandType:ValidateProtocol.Type = self.commands.popLast() {
            let command:ValidateProtocol = commandType.init()
            command.delegate = self
            command.validate(pyro:self.pyro, url:self.url)
        } else {
            self.delegate?.validateSuccess()
        }
    }
    
    func validateFailed(error:Error) {
        self.delegate?.validateFailed(error:error)
    }
}
