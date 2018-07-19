import Foundation

public struct Stats:Codable {
    public var timestamp:Date
    public var contributions:Contributions
    public var streak:Streak
    
    public init() {
        self.timestamp = Date()
        self.contributions = Contributions()
        self.streak = Streak()
    }
}
