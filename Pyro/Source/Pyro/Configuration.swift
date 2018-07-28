import Foundation

struct Configuration:ConfigurationProtocol {
    typealias UserType = User_v2
    typealias SessionType = Session_v1
    static var requestType:RequestProtocol.Type = Request.self
}

private protocol ConfigurationProtocol {
    associatedtype UserType:UserProtocol
    associatedtype SessionType:SessionProtocol
}
