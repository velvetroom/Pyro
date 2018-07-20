import Foundation

public struct Contributions:Codable {
    public var years:[Year]
    public var max:Max
    public var first:Date
    public var last:Date
    public var count:Int
    
    public init() {
        self.years = []
        self.max = Max()
        self.first = Date.distantPast
        self.last = Date.distantPast
        self.count = 0
    }
}
