import Foundation
import CleanArchitecture

class StatsInteractor:InteractorProtocol {
    weak var presenter:InteractorDelegateProtocol?
    var user:User
    
    required init() {
        self.user = User()
    }
}
