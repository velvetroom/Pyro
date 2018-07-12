import Foundation

public struct User:Codable {
    public var identifier:String
    public var name:String
    public var url:String
    public var stats:Stats
    
    public init() {
        self.identifier = String()
        self.name = String()
        self.url = String()
        self.stats = Stats()
    }
}
