import UIKit

public extension ViewProtocol {
    var viewController:UIViewController {
        get {
            return self as! UIViewController
        }
    }
}
