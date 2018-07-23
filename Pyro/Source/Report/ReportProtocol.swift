import Foundation

protocol ReportProtocol {
    var delegate:ReportDelegate? { get set }
    
    func make(user:User_v1)
}
