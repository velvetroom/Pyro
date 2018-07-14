import Foundation

public struct Stats:Codable {
    public var timestamp:Date?
    public var contributions:StatsContributions
    public var streak:StatsStreak
    public var histogram:StatsHistogram
    
    public init() {
        self.contributions = StatsContributions()
        self.streak = StatsStreak()
        self.histogram = StatsHistogram()
    }
}
