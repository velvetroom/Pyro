import Foundation

class User_v1:UserProtocol, Codable {
    var name:String
    var url:String
    var metrics:Metrics?
    let identifier:String
    
    public required init() {
        self.identifier = UUID().uuidString
        self.name = String()
        self.url = String()
    }
}
