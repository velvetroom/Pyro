import Foundation
import Pyro

struct UsersViewModelItem {
    weak var user:User?
    var name:NSAttributedString
    var value:String
    
    init() {
        self.name = NSAttributedString()
        self.value = String()
    }
}
