import Foundation

public struct StatsHistogramMonth:Codable {
    public var year:Int
    public var month:Int
    public var value:Int
    
    init() {
        self.year = 0
        self.month = 0
        self.value = 0
    }
}
