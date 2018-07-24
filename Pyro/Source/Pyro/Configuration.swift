import Foundation

struct Configuration:ConfigurationProtocol {
    typealias User = User_v2
    typealias Session = Session_v1
}

private protocol ConfigurationProtocol {
    associatedtype User:UserProtocol
    associatedtype Session:SessionProtocol
}
