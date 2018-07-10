import Foundation
import CleanArchitecture
import Pyro

class StatsInteractor:InteractorProtocol {
    weak var transition:Navigation?
    weak var presenter:InteractorDelegateProtocol?
    var user:User
    
    required init() {
        self.user = User()
    }
}
