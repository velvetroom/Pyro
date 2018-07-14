import Foundation

public protocol PyroDelegate:AnyObject {
    func pyroUpdated()
    func pyroFailed(error:Error)
}
