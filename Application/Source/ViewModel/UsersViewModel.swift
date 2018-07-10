import Foundation
import CleanArchitecture

struct UsersViewModel:ViewModelPropertyProtocol {
    var observing:((UsersViewModel) -> Void)?
    var users:[NSAttributedString]
    
    init() {
        self.users = []
    }
}
