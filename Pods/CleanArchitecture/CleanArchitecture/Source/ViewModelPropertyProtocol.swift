import Foundation

public protocol ViewModelPropertyProtocol {
    var observing:((Self) -> Void)? { get set }
    
    init()
}
