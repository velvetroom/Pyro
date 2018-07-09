import Foundation
import CleanArchitecture

class Interactor:InteractorProtocol {
    weak var presenter:InteractorDelegateProtocol?
    
    required init() { }
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        let storage:Storage = Storage()
        storage.load(onCompletion:onCompletion)
    }
}
