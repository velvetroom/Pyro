import Foundation
@testable import Pyro

class MockReportProtocol:ReportProtocol {
    var onReport:(() -> Void)?
    weak var delegate:ReportDelegate?
    
    func make(user:UserProtocol) {
        self.onReport?()
    }
}
