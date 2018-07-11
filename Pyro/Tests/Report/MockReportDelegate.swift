import Foundation
@testable import Pyro

class MockReportDelegate:ReportDelegate {
    var onCompleted:(() -> Void)?
    var onError:(() -> Void)?
    
    func reportCompleted(stats:Stats) {
        self.onCompleted?()
    }
    
    func reportFailed(error: Error) {
        self.onError?()
    }
}
