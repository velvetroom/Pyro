import Foundation

public protocol PyroDelegate:AnyObject {
    func pyroReport(progress:Float)
    func pyroSuccess()
    func pyroFailed(error:Error)
}

public extension PyroDelegate {
    func pyroReport(progress:Float) { }
    func pyroSuccess() { }
    func pyroFailed(error:Error) { }
}
