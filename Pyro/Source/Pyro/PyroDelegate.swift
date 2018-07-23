import Foundation

public protocol PyroDelegate:AnyObject {
    func pyroReport(progress:Float)
    func pyroUpdated()
    func pyroFailed(error:Error)
}

public extension PyroDelegate {
    func pyroReport(progress:Float) { }
    func pyroUpdated() { }
    func pyroFailed(error:Error) { }
}
