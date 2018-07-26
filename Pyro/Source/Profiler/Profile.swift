import Foundation

public struct Profile {
    public var user:String
    public var name:String
    public var bio:String
    
    init() {
        self.user = String()
        self.name = String()
        self.bio = String()
    }
}
