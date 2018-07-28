import Foundation

protocol ReportDelegate:AnyObject {
    func report(progress:Float)
    func reportCompleted()
    func reportFailed(error:Error)
}
