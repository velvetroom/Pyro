import Foundation
@testable import Pyro

class MockReportProtocol:ReportProtocol {
    var onReport:(() -> Void)?
    weak var delegate:ReportDelegate?
    
    func report(user:User) {
        self.onReport?()
    }
}
