import Foundation
import CleanArchitecture

struct UsersViewModel:ViewModelProtocol {
    var users:[UsersViewModelItem]
    
    init() {
        self.users = []
    }
}
