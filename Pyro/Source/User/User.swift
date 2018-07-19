import Foundation

public class User:Codable {
    public var name:String
    public var url:String
    public var metrics:Metrics?
    var identifier:String
    
    init() {
        self.identifier = String()
        self.name = String()
        self.url = String()
        self.metrics = Metrics()
    }
}
