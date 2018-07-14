import Foundation

public struct StatsContributions:Codable {
    public var first:Date
    public var last:Date
    public var count:Int
    
    public init() {
        self.first = Date.distantPast
        self.last = Date.distantPast
        self.count = 0
    }
}
