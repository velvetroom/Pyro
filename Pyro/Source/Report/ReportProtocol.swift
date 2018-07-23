import Foundation

protocol ReportProtocol {
    var delegate:ReportDelegate? { get set }
    
    func make(user:UserProtocol)
}
