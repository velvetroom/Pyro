import Foundation

public struct Stats:Codable {
    public var firstContribution:Date
    public var lastContribution:Date
    public var contributions:Int
    public var maxStreak:Int
    public var currentStreak:Int
    
    public init() {
        self.firstContribution = Date.distantPast
        self.lastContribution = Date.distantPast
        self.contributions = 0
        self.maxStreak = 0
        self.currentStreak = 0
    }
}
