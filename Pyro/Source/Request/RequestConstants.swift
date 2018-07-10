import Foundation

struct RequestConstants {
    static let identifier:String = "iturbide.Pyro"
    static let method:String = "GET"
    static let urlPrefix:String = "https://github.com/users/"
    static let urlMiddle:String = "/contributions?from="
    static let urlSuffix:String = "-01-01"
    static let timeout:TimeInterval = 15
}
