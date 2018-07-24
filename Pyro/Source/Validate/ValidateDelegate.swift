import Foundation

protocol ValidateDelegate:AnyObject {
    func validateSuccess()
    func validateFailed(error:Error)
}
