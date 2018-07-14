import Foundation

public struct Stats:Codable {
    public var timestamp:Date?
    public var contributions:StatsContributions
    public var streak:StatsStreak
    
    public init() {
        self.contributions = StatsContributions()
        self.streak = StatsStreak()
    }
}
