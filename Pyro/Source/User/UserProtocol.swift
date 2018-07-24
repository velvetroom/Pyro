import Foundation

public protocol UserProtocol:AnyObject {
    var name:String { get set }
    var url:String { get set }
    var user:String { get set }
    var bio:String { get set }
    var metrics:Metrics? { get set }
}
