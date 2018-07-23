import Foundation
import Pyro

struct UsersItem {
    weak var user:UserProtocol!
    var name:NSAttributedString
    var value:NSAttributedString
    
    init() {
        self.name = NSAttributedString()
        self.value = NSAttributedString()
    }
}
