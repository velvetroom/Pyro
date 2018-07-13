import Foundation

public struct User:Codable {
    public var name:String
    public var url:String
    public var stats:Stats
    var identifier:String
    
    init() {
        self.identifier = String()
        self.name = String()
        self.url = String()
        self.stats = Stats()
    }
}
