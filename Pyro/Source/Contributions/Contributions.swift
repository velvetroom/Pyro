import Foundation

public struct Contributions:Codable {
    public var first:Date
    public var last:Date
    public var count:Int
    public var maxDay:Int
    
    public init() {
        self.first = Date.distantPast
        self.last = Date.distantPast
        self.count = 0
        self.maxDay = 0
    }
}
