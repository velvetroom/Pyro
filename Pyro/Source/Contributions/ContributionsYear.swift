import Foundation

public struct ContributionsYear:Codable {
    public var months:[ContributionsMonth]
    public var contributions:Int
    public var value:Int
    
    init() {
        self.months = []
        self.contributions = 0
        self.value = 0
    }
}
