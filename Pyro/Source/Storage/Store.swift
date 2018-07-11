import Foundation

struct Store:Codable {
    var users:[User]
    
    init() {
        self.users = []
    }
}
