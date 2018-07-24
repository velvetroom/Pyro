import Foundation
import CleanArchitecture

class CreateInteractor:InteractorProtocol {
    weak var router:Router?
    weak var presenter:InteractorDelegate?
    
    required init() { }
}
