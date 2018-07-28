import Foundation

class User_v1:Codable {
    var metrics:Metrics?
    var name:String
    var url:String
    var identifier:String
    
    init() {
        self.identifier = String()
        self.name = String()
        self.url = String()
    }
}
