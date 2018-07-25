import Foundation

public protocol PyroDelegate:AnyObject {
    func pyroUsersLoaded()
    func pyroReportReady()
    func pyroValidated()
    func pyroReport(progress:Float)
    func pyroFailed(error:Error)
}

public extension PyroDelegate {
    func pyroUsersLoaded() { }
    func pyroReportReady() { }
    func pyroValidated() { }
    func pyroReport(progress:Float) { }
    func pyroFailed(error:Error) { }
}
