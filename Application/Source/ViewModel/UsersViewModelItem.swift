import Foundation
import Pyro

struct UsersViewModelItem {
    weak var user:User!
    var name:NSAttributedString
    var value:NSAttributedString
    
    init() {
        self.name = NSAttributedString()
        self.value = NSAttributedString()
    }
}
