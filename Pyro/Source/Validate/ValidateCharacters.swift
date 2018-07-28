import Foundation

class ValidateCharacters:ValidateProtocol {
    weak var delegate:ValidateDelegate?
    
    required init() { }
    
    func validate(pyro:Pyro, url:String) {
        for character:UInt8 in url.utf8 {
            if self.invalid(character:character) {
                self.delegate?.validateFailed(error:ValidateError.character)
                return
            }
        }
        self.delegate?.validateSuccess()
    }
    
    private func invalid(character:UInt8) -> Bool {
        if character >= "0".utf8.first! && character <= "9".utf8.first! { return false }
        if character >= "a".utf8.first! && character <= "z".utf8.first! { return false }
        if character >= "A".utf8.first! && character <= "Z".utf8.first! { return false }
        if character == "-".utf8.first! { return false }
        return true
    }
}
