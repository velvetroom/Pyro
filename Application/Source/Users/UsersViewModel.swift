import Foundation
import CleanArchitecture

struct UsersViewModel:ViewModelProtocol {
    var users:[UsersItem]
    
    init() {
        self.users = []
    }
}
