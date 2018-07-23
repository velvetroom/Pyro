import Foundation

struct Configuration:ConfigurationProtocol {
    typealias User = User_v1
    typealias Session = Session_v1
}

private protocol ConfigurationProtocol {
    associatedtype User:UserProtocol, Encodable
    associatedtype Session:SessionProtocol, Encodable
}
