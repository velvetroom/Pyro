import Foundation
import Pyro

struct UsersItem {
    weak var user:User_v1!
    var name:NSAttributedString
    var value:NSAttributedString
    
    init() {
        self.name = NSAttributedString()
        self.value = NSAttributedString()
    }
}
