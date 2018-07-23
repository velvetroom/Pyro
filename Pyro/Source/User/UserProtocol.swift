import Foundation

public protocol UserProtocol {
    var name:String { get }
    var url:String { get }
    var metrics:Metrics? { get }
}
