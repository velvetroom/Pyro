import Foundation
import CleanArchitecture
import Pyro

struct UsersViewModel:ViewModel {
    var users:[UsersItem]
    
    init() {
        self.users = []
    }
}

struct UsersItem {
    weak var user:UserProtocol!
    var name:NSAttributedString
    var value:String
    var avatar:String
    
    init() {
        self.name = NSAttributedString()
        self.value = String()
        self.avatar = String()
    }
}
