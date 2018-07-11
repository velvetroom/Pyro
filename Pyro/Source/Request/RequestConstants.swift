import Foundation

struct RequestConstants {
    static let method:String = "GET"
    static let urlPrefix:String = "https://github.com/users/"
    static let urlMiddle:String = "/contributions?from="
    static let urlSuffix:String = "-01-01"
    static let timeout:TimeInterval = 15
    static let codeSuccess:Int = 200
    static let codeFourZeroFour:Int = 404
    static let codeBanned:Int = 429
}
