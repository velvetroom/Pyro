import Foundation

public protocol ReportDelegate:AnyObject {
    func reportCompleted(stats:Stats)
    func reportFailed(error:Error)
}
