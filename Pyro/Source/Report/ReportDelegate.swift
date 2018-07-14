import Foundation

protocol ReportDelegate:AnyObject {
    func reportCompleted()
    func reportFailed(error:Error)
}
