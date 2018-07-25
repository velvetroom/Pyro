import Foundation
import CleanArchitecture

struct UsersViewModel:ViewModel {
    var users:[UsersItem]
    
    init() {
        self.users = []
    }
}
