import Foundation
import CleanArchitecture

class UserInteractor:InteractorProtocol {
    weak var presenter:InteractorDelegateProtocol?
    
    required init() { }
    
    func load(onCompletion:@escaping(([User]) -> Void)) {
        let storage:Storage = Storage()
        storage.load(onCompletion:onCompletion)
    }
}
