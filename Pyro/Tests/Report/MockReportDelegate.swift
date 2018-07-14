import Foundation
@testable import Pyro

class MockReportDelegate:ReportDelegate {
    var onCompleted:(() -> Void)?
    var onError:(() -> Void)?
    
    func reportCompleted() {
        self.onCompleted?()
    }
    
    func reportFailed(error:Error) {
        self.onError?()
    }
}
