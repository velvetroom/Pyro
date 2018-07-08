import Foundation
import CleanArchitecture

class Interactor:InteractorProtocol {
    weak var presenter:InteractorDelegateProtocol?
    
    required init() { }
}
