import Foundation

public struct StatsHistogram:Codable {
    public var months:[StatsHistogramMonth]
    public var maxValue:Int
    
    init() {
        self.months = []
        self.maxValue = 0
    }
}
