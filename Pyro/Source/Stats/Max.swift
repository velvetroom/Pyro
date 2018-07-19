import Foundation

public struct Max:Codable {
    public var year:Int
    public var month:Int
    public var day:Int
    
    init() {
        self.year = 0
        self.month = 0
        self.day = 0
    }
}
