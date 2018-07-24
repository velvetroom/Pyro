import Foundation

struct Configuration:ConfigurationProtocol {
    typealias UserType = User_v2
    typealias SessionType = Session_v1
}

private protocol ConfigurationProtocol {
    associatedtype UserType:UserProtocol
    associatedtype SessionType:SessionProtocol
}
