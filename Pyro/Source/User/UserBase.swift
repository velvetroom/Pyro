import Foundation

struct UserBase:Codable {
    var name:String
    var url:String
    
    init() {
        self.name = String()
        self.url = String()
    }
}
