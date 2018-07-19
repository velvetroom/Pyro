import Foundation

public struct Streak:Codable {
    public var max:Int
    public var current:Int
    
    init() {
        self.max = 0
        self.current = 0
    }
}
