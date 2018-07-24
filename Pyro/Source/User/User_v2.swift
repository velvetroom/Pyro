import Foundation

class User_v2:UserProtocol, Codable {
    var metrics:Metrics?
    var name:String
    var url:String
    var user:String
    var bio:String
    var identifier:String
    
    init() {
        self.identifier = String()
        self.name = String()
        self.url = String()
        self.user = String()
        self.bio = String()
    }
}
