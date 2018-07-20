import Foundation

public struct Year:Codable {
    public var months:[Month]
    public var contributions:Int
    public var value:Int
    
    init() {
        self.months = []
        self.contributions = 0
        self.value = 0
    }
}
