import Foundation

public struct ContributionsMonth:Codable {
    public var contributions:Int
    public var value:Int
    
    init() {
        self.contributions = 0
        self.value = 0
    }
}
