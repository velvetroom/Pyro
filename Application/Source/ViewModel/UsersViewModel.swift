import Foundation
import CleanArchitecture

struct UsersViewModel:ViewModelProtocol {
    var users:[NSAttributedString]
    
    init() {
        self.users = []
    }
}
