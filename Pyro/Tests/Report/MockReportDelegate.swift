import Foundation
@testable import Pyro

class MockReportDelegate:ReportDelegate {
    var onCompleted:(() -> Void)?
    var onError:(() -> Void)?
    var onProgress:(() -> Void)?
    
    func report(progress:Float) {
        self.onProgress?()
    }
    
    func reportCompleted() {
        self.onCompleted?()
    }
    
    func reportFailed(error:Error) {
        self.onError?()
    }
}
