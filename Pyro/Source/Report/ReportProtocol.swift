import Foundation

public protocol ReportProtocol {
    var delegate:ReportDelegate? { get set }
    
    func make(user:User)
}
